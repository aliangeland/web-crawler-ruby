require "redis"

module Crawler
  class Cache
    def initialize()
      @redis = Redis.new(host: "127.0.0.1", port: 6379)
    end

    def addToSet(key, member)
      # key is our saved set
      return @redis.sadd(key, member)
    end

    def exists(key, member)
      return @redis.sismember(key, member)
    end
  end
end
