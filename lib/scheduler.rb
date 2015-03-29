require 'bundler'
Bundler.require

require 'sidekiq'
require_relative './worker/cache'
require_relative './worker/realtime'

ESPN::Cache.client = Worker::Cache

module Worker
  def self.redis
    @@redis ||= Redis.new(url: ENV['REDISTOGO_URL'])
  end
end

class Worker::ESPN
  include Sidekiq::Worker

  def perform
    Worker::Cache.clear
    ESPN::Cache.precache
  end
end

#class RealtimePush
  #include Sidekiq::Worker

  #def perform
    #Realtime::Checker.push_updates
  #end
#end
