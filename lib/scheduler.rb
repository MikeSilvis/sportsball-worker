require 'bundler'
Bundler.require

require 'sidekiq'
require_relative './worker/cache'

ESPN::Cache.client = Worker::Cache

module Worker
  def self.redis
    @@redis ||= Redis.new(url: ENV['REDISTOGO_URL'])
  end
end

class Worker::Cache
  include Sidekiq::Worker

  def perform
    #Rails.cache.flush
    #ESPN::Cache.precache
  end
end
