#/usr/bin/env python
REDIS_DB = 0
REDIS_PORT = 6379
REDIS_HOST = 'localhost'

RETWIS_HOST = 'localhost'
RETWIS_PORT = 8008

SALT = 'retwis'

#serves as "hub" for dynamic settings of redis
#ugly hack, needs to be fixed in next update
r = None
