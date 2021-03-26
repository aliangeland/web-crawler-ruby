require "redis"
require "dotenv/load"

module Crawler
  class Cache
    def initialize()
      @redis = Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"])
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
