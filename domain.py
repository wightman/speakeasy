#!/usr/bin/env python
import redis
import re
import settings

r = settings.r

# class Timeline:
#   def page(self,page):
#     _from = (page-1)*10
#     _to = (page)*10
#     return [Post(post_id) for post_ids in r.list_range('timeline',_from,_to)]

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
  def create(username, password, attributes):
    user_id = r.incr("user:uid")
    if not r.get("user:username:%s" % username):
      r.set("user:id:%s:username" % user_id, username)
      r.set("user:username:%s" % username, user_id)
    
      #fake salting obviously :)
      salt = settings.SALT
      r.set("user:id:%s:password" % user_id, salt+password)
      r.lpush("users", user_id)

      user = User(user_id)

      if user:
        user.updateAttributes(attributes)
	return user

    return None

  def updateAttributes(self,attributes):
	for k,v in attributes.iteritems():
		if k == "password":
			salt = settings.SALT
			v = salt + v

		self.__setattr__(k,v)
      		r.set("user:id:%s:%s" % (self.id, k) , v)

  def posts(self,page=1):
    return self.posts_helper("posts")
  
  def timeline(self,page=1):
    return self.posts_helper("timeline")

  def mentions(self,page=1):
    return self.posts_helper("mentions")

  def posts_helper(self, name,page=1):
    list_length = r.llen("user:id:%s:%s" % (self.id, name))
    index = (page-1)*100
    counter = (page-1)*100
    post_list = []
    print index
    print list_length
    while index < list_length and counter < page*100:
      print index
      post_id = r.lindex("user:id:%s:%s" % (self.id, name), index)
      post = Post(int(post_id))
      try:
        if post.is_active == 'True':
          post_list.append(post)
          counter += 1
      except AttributeError:
        post_list.append(post)
        counter+=1
      index += 1
    return post_list

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

  @property
  def firstName(self):
	return r.get("user:id:%s:firstName" % self.id) or ""

  @property
  def firstName(self):
	return r.get("user:id:%s:firstName" % self.id) or ""

  @property
  def lastName(self):
	return r.get("user:id:%s:lastName" % self.id) or ""

  @property
  def greeting(self):
	return r.get("user:id:%s:greeting" % self.id) or ""

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
    post.is_active = True
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

  @staticmethod
  def delete(id):
    if Post.find_by_id(id):
      r.set("post:id:%s:is_active" % id, False)
  
  @property
  def user(self):
    return User.find_by_id(r.get("post:id:%s:user_id" % self.id))

class Hashtag:

  @staticmethod
  def page(tag,page):
    _from = (page-1)*10
    _to = (page)*10
    return [Post(post_id) for post_id in r.lrange('hashtags:%s' % tag.lower(),_from,_to)]

  @staticmethod
  def keyIsMember(tag):
    return r.sismember('hashtags', tag.lower())
  
  @staticmethod
  def addToTag(tag, post_id):
    r.rpush('hashtags:%s' % tag.lower(), post_id)

  @staticmethod
  def addNewTag(tag):
    r.sadd('hashtags', tag.lower())

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

  @staticmethod
  def recent():
    
      if r.get("post:uid") == None:
        return []
      else:
        post_id = int(r.get("post:uid"))
        counter = 0
        post_list = []
        while counter < 100 and post_id > 0:
          post = Post(int(post_id))
          try:
            if post.is_active == 'True':
              post_list.append(post)
              counter += 1
          except AttributeError:
            post_list.append(post)
            counter+=1
          post_id -= 1
        return post_list
  
def main():
  pass

if __name__ == '__main__':
  main()
