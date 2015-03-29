module SportsBall
  def self.redis
    @@redis ||= Redis.new(url: ENV['REDISTOGO_URL'])
  end
end

class SportsBall::Cache
  include Sidekiq::Worker

  def perform
    Rails.cache.clear
    ESPN::Cache.precache
  end
end
