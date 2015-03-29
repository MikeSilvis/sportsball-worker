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

class Worker::ESPN
  include Sidekiq::Worker

  def perform
    Worker::Cache.flush
    ESPN::Cache.precache
  end
end
