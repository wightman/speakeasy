#!/usr/bin/env python

import bottle
import redis
import settings
#ugly hack
settings.r = redis.Redis(host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=settings.REDIS_DB)

from bottle_session import Session
from domain import Hashtag,User,Post,Functions#,Timeline

reserved_usernames = 'follow mentions home signup login logout post guest'
bottle.debug(True)

def authenticate(handler):
  def _check_auth(*args,**kwargs):
    sess = Session(bottle.request,bottle.response)
    if not sess.is_new():
      user =  User.find_by_id(sess['id'])
      if user:
        return handler(user,*args,**kwargs)
    bottle.redirect('/login')
  return _check_auth

#this is used when we need to distinguish between a user and a guest, 
#as opposed to authentication which will lock guests out.
def userCheck(handler):
  def _check_auth(*args,**kwargs):
    sess = Session(bottle.request,bottle.response)
    if not sess.is_new():
      user =  User.find_by_id(sess['id'])
      if user:
        return handler(user,*args,**kwargs)
    return handler(None,*args,**kwargs)
  return _check_auth


def logged_in_user():
  sess = Session(bottle.request,bottle.response)
  if not sess.is_new():
      return User.find_by_id(sess['id'])
  return None

def user_is_logged():
  if logged_in_user():
    return True
  return False

@bottle.route("/:page/delete/:id")
@authenticate
def delete(user, page, id):
  post = Post(int(id))
  if post.user == user:
    user.delete(id)
    bottle.redirect('/'+page)
  else:
    bottle.redirect('/'+page)




@bottle.route('/')
def index():
  if user_is_logged():
    bottle.redirect('/home')
  return bottle.template('home_not_logged',recent=Functions.recent(), logged=False)

@bottle.route('/home')
@authenticate
def home(user):
  bottle.TEMPLATES.clear()
  counts = user.followees_count,user.followers_count,user.tweet_count
  if len(user.posts()) >0:
    last_tweet = user.posts()[0]
  else:
    last_tweet = None
  return bottle.template('timeline',timeline=user.timeline(),page='timeline',username=user.username,
                                    counts=counts,last_tweet=last_tweet,logged=True)

@bottle.route('/mentions')
@authenticate
def mentions(user):
  counts = user.followees_count,user.followers_count,user.tweet_count
  return bottle.template('mentions',mentions=user.mentions(),page='mentions',username=user.username,
                                    counts=counts,posts=user.posts()[:1],logged=True)

@bottle.route('/recent')
@authenticate
def mentions(user):
  counts = user.followees_count,user.followers_count,user.tweet_count
  return bottle.template('recent',recent=Functions.recent(),page='timeline',username=user.username,
                                    counts=counts,posts=user.posts()[:1],logged=True)

@bottle.route('/hashtag/:ht')
@userCheck
def hashtags(user, ht):
  if user != None:
    counts = user.followees_count,user.followers_count,user.tweet_count
    return bottle.template('hashtag',title=ht, hashtags=Hashtag.page(ht, page=1),page='timeline',username=user.username,
                                      counts=counts,posts=user.posts()[:1],logged=True)
  else:
    return bottle.template('guest/hashtag', title=ht, hashtags=Hashtag.page(ht, page=1),page='timeline',
                                      logged=False)  

@bottle.route('/followers')
@authenticate
def followers(user):
  counts = user.followees_count,user.followers_count,user.tweet_count
  return bottle.template('followers',followers=user.followers,page='followers',username=user.username,
                                    counts=counts,posts=user.posts()[:1],logged=True)
  
@bottle.route('/following')
@authenticate
def followers(user):
  counts = user.followees_count,user.followers_count,user.tweet_count
  return bottle.template('following',followers=user.followees,page='following',username=user.username,
                                    counts=counts,posts=user.posts()[:1],logged=True)  

@bottle.route('/users')
@userCheck
def users(user):
  if user != None:
    counts = user.followees_count,user.followers_count,user.tweet_count
    return bottle.template('users',users=Functions.getUsers(),page='timeline',username=user.username,
                                      counts=counts,posts=user.posts()[:1],logged=True)
  else:
    return bottle.template('guest/users',users=Functions.getUsers(), page='timeline',logged=False)

@bottle.route('/:name')
@userCheck
def user_page(auth, name):
  user = User.find_by_username(name)
  if user:
    counts = user.followees_count,user.followers_count,user.tweet_count
    if auth != None:
      is_following,is_logged = False,user_is_logged()
      logged_user = logged_in_user()
      himself = logged_user.username == name
      if logged_user:
        is_following = logged_user.following(user)
      return bottle.template('user',user=user,posts=user.posts(),counts=counts,page='timeline',
                                  username=user.username,logged=is_logged,is_following=is_following,himself=himself,viewer=auth.username)
    else:
      return bottle.template('guest/user',user=user,posts=user.posts(),counts=counts,page='timeline', 
                                username=user.username, logged=False)
  return bottle.HTTPError(code=404,message='tweet not found')  

@bottle.route('/:name/statuses/:id')
@bottle.validate(id=int)
@userCheck
def status(auth, name,id):
  post = Post.find_by_id(id)
  if post:
    if post.user.username == name:
      if auth != None:
        return bottle.template('single',username=post.user.username,tweet=post,page='single',
                                      logged=user_is_logged(),viewer=auth.username)
      else:
        return bottle.template('single',username=post.user.username,tweet=post,page='single',
                                      logged=user_is_logged(),viewer="")
  return bottle.HTTPError(code=404,message='tweet not found')  


@bottle.route('/post',method='POST')
@authenticate
def post(user):
  try:
    content = bottle.request.POST['content']
    Post.create(user, content)
  except KeyError, e:
    pass
  finally:
    bottle.redirect('/home')

@bottle.route('/follow/:name',method='POST')
@authenticate
def post(user,name):
  user_to_follow = User.find_by_username(name)
  if user_to_follow:
    user.follow(user_to_follow)
  bottle.redirect('/%s' % name)
[]
@bottle.route('/unfollow/:name',method='POST')
@authenticate
def post(user,name):
  user_to_unfollow = User.find_by_username(name)
  if user_to_unfollow:
    user.stop_following(user_to_unfollow)
  bottle.redirect('/%s' % name)

@bottle.route('/edit/:name', method='GET')
@authenticate
def get(user, name):
  bottle.TEMPLATES.clear()
  return bottle.template('editProfile',page='timeline',logged=True,user=user)

@bottle.route('/edit', method="POST")
@authenticate
def edit(user):
	
	attributes = {}
	if 'firstName' in bottle.request.POST:
		attributes['firstName'] = bottle.request.POST['firstName']
 
	if 'lastName' in bottle.request.POST:
		attributes['lastName'] = bottle.request.POST['lastName']

	if 'greeting' in bottle.request.POST:
		attributes['greeting'] = bottle.request.POST['greeting']

	# For now, lets leave password out, we may want a seperate screen to update password
	# this gets confusing when salting password.

	#if 'password' in bottle.request.POST:
	#	attributes['password'] = bottle.request.POST['password']

	user.updateAttributes(attributes)

	bottle.redirect('/' + user.username)

@bottle.route('/signup')
@bottle.route('/login')
def login():
  bottle.TEMPLATES.clear()
  if user_is_logged():
    bottle.redirect('/home')
  return bottle.template('login',page='login',error_login=False,error_signup=False,logged=False)

@bottle.route('/login', method='POST')
def login():
  if 'name' in bottle.request.POST and 'password' in bottle.request.POST:
    name = bottle.request.POST['name']
    password = bottle.request.POST['password']
  
    user = User.find_by_username(name)
    if user and user.password == settings.SALT + password:
      sess=Session(bottle.request,bottle.response)
      sess['id'] = user.id
      sess.save()
      bottle.redirect('/home')

  return bottle.template('login',page='login',error_login=True,error_signup=False,logged=False)

@bottle.route('/logout')
def logout():
  sess = Session(bottle.request,bottle.response)
  sess.invalidate()
  bottle.redirect('/')


@bottle.route('/signup', method='POST')
def sign_up():
  if 'name' in bottle.request.POST and 'password' in bottle.request.POST:
    name = bottle.request.POST['name']
    if name not in reserved_usernames.split():
      password = bottle.request.POST['password']
	
      attributes = {}
      if 'firstName' in bottle.request.POST:
	attributes['firstName'] = bottle.request.POST['firstName']
	
      if 'lastName' in bottle.request.POST:
	attributes['lastName'] = bottle.request.POST['lastName']

      if 'greeting' in bottle.request.POST:
	attributes['greeting'] = bottle.request.POST['greeting']

      user = User.create(name,password, attributes)
      if user:
        sess=Session(bottle.request,bottle.response)
        sess['id'] = user.id
        sess.save()
        bottle.redirect('/home')
    return bottle.template('login',page='login',error_login=False,error_signup=True,logged=False)

@bottle.route('/static/:filename')
def static_file(filename):
  bottle.send_file(filename, root='static/')
    
bottle.run(host=settings.RETWIS_HOST, port=settings.RETWIS_PORT,reloader=True)
