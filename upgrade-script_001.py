#!/usr/bin/env python
import redis
import re
import settings
 
settings.r = redis.Redis(host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=settings.REDIS_DB)
r = settings.r

# We want hashtags to be case-insensitive
# The easiest way to do this seems to be to save them in a case insensitive way (we choose all lower-case)
#
# This script is to convert all existing hastags in the database to follow this convention


hashtags = r.keys("hashtags:*")

if (hashtags != None):
	for hashtag in hashtags:
		r.rename(hashtag, hashtag.lower())

	print "Processing complete"

