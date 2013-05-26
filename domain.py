#!/usr/bin/env python
import redis
import re
import settings

r = settings.r

class Timeline:
  def page(self,page):
    _from = (page-1)*10
    _to = (page)*10
    return [Post(post_id) for post_ids in r.list_range('timeline',_from,_to)]

class Model(object):
  def __init__(self,id):
    self.__dict__['id'] = id

  def __eq__(self,other):
    return self.id == other.id

  def __setattr__(self,name,value):
    if name not in self.__dict__:
      klass = self.__class__.__name__.lower()
      key = '%s:id:%s:%s' % (klass,self.id,name.lower())
      r.set(key,value)
    else:
      self.__dict__[name] = value

  def __getattr__(self,name):
    if name not in self.__dict__:
      klass = self.__class__.__name__.lower()
      v = r.get('%s:id:%s:%s' % (klass,self.id,name.lower()))
      if v:
        return v
      raise AttributeError('%s doesn\'t exist' % name) 
    else:
      self.__dict__[name] = value
          
class User(Model):
  @staticmethod
  def find_by_username(username):
    _id = r.get("user:username:%s" % username)
    if _id is not None:
      return User(int(_id))
    else:
      return None

  @staticmethod
  def find_by_id(_id):
    if r.exists("user:id:%s:username" % _id):
      return User(int(_id))
    else:
      return None

  @staticmethod
  def create(username, password):
    user_id = r.incr("user:uid")
    if not r.get("user:username:%s" % username):
      r.set("user:id:%s:username" % user_id, username)
      r.set("user:username:%s" % username, user_id)
    
      #fake salting obviously :)
      salt = settings.SALT
      r.set("user:id:%s:password" % user_id, salt+password)
      r.lpush("users", user_id)
      return User(user_id)
    return None

  def posts(self,page=1):
    _from, _to = (page-1)*10, page*10
    posts = r.lrange("user:id:%s:posts" % self.id, _from, _to)
    if posts:
      return [Post(int(post_id)) for post_id in posts]
    return []
  
  def timeline(self,page=1):
    _from, _to = (page-1)*10, page*10
    timeline= r.lrange("user:id:%s:timeline" % self.id, _from, _to)
    mentions = r.lrange("user:id:%s:mentions" % self.id, _from, _to)
    if mentions and timeline:
      timeline.extend(mentions)
    if timeline:
      return [Post(int(post_id)) for post_id in timeline]
    return []

  def recent(self):
    mostrecentpid = int(r.get("post:uid"))
    
    if mostrecentpid < 100:
      return [Post(int(post_id)) for post_id in xrange(mostrecentpid,0,-1)]
    else:
      return [Post(int(post_id)) for post_id in xrange(mostrecentpid,mostrecentpid-100,-1)]
    return []

  def mentions(self,page=1):
    _from, _to = (page-1)*10, page*10
    mentions = r.lrange("user:id:%s:mentions" % self.id, _from, _to)
    if mentions:
      return [Post(int(post_id)) for post_id in mentions]
    return []

  def add_post(self,post):
    r.lpush("user:id:%s:posts" % self.id, post.id)
    r.lpush("user:id:%s:timeline" % self.id, post.id)
    r.sadd('posts:id', post.id)

  def add_timeline_post(self,post):
    r.lpush("user:id:%s:timeline" % self.id, post.id)
  
  def add_mention(self,post):
    r.lpush("user:id:%s:mentions" % self.id, post.id)

  def follow(self,user):
    if user == self:
      return
    else:
      r.sadd("user:id:%s:followees" % self.id, user.id)
      user.add_follower(self)

  def stop_following(self,user):
    r.srem("user:id:%s:followees" % self.id, user.id)
    user.remove_follower(self)

  def following(self,user):
    if r.sismember("user:id:%s:followees" % self.id, user.id):
      return True
    return False

  @property
  def followers(self):
    followers = r.smembers("user:id:%s:followers" % self.id)
    if followers:
      return [User(int(user_id)) for user_id in followers]
    return []
  
  @property
  def followees(self):
    followees = r.smembers("user:id:%s:followees" % self.id)
    if followees:
      return [User(int(user_id)) for user_id in followees]
    return []
  
  @property
  def tweet_count(self):
    return r.llen("user:id:%s:posts" % self.id) or 0
  
  @property
  def followees_count(self):
    return r.scard("user:id:%s:followees" % self.id) or 0
    
  @property
  def followers_count(self):
    return r.scard("user:id:%s:followers" % self.id) or 0

  def add_follower(self,user):
    r.sadd("user:id:%s:followers" % self.id, user.id)

  def remove_follower(self,user):
    r.srem("user:id:%s:followers" % self.id, user.id)

class Post(Model):
  @staticmethod
  def create(user, content):
    post_id = r.incr("post:uid")
    post = Post(post_id)
    post.content = content
    post.user_id = user.id
    #post.created_at = Time.now.to_s
    user.add_post(post)
    r.lpush("timeline", post_id)
    for follower in user.followers:
      follower.add_timeline_post(post)
    
    mentions = re.findall('@\w+', content)
    for mention in mentions:
      u = User.find_by_username(mention[1:])
      if u:
        u.add_mention(post)

    hashtags = re.findall('#\w+', content)
    for hashtag in hashtags:
      if Hashtag.keyIsMember(hashtag[1:]):
        Hashtag.addToTag(hashtag[1:], post_id)
      else:
        Hashtag.addNewTag(hashtag[1:])
        Hashtag.addToTag(hashtag[1:], post_id)

  @staticmethod
  def find_by_id(id):
    if r.sismember('posts:id', int(id)):
      return Post(id)
    return None
  
  @property
  def user(self):
    return User.find_by_id(r.get("post:id:%s:user_id" % self.id))

class Hashtag:

  @staticmethod
  def page(tag,page):
    _from = (page-1)*10
    _to = (page)*10
    return [Post(post_id) for post_id in r.lrange('hashtags:%s' % tag,_from,_to)]

  @staticmethod
  def keyIsMember(tag):
    return r.sismember('hashtags', tag)
  
  @staticmethod
  def addToTag(tag, post_id):
    r.rpush('hashtags:%s' % tag, post_id)

  @staticmethod
  def addNewTag(tag):
    r.sadd('hashtags', tag)

class Functions:

  @staticmethod
  def getUsers():
    lastid = int(r.get('user:uid'))
    usernames = []
    for i in xrange(1,lastid+1):
      u = r.get("user:id:%s:username" % str(i))
      if u == None:
        pass
      else:
        usernames.append(u)
    usernames.sort()
    userList = []
    for u in usernames:
      userList.append(User.find_by_username(u))
    return userList
  
def main():
  pass

if __name__ == '__main__':
  main()
