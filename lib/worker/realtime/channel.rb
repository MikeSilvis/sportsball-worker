class Realtime::Channel
  def self.verify
    client.set channel_key, all.any?
  end

  def self.any?
    client.get(channel_key) == 'true'
  end

  def self.all
    @channels ||= Realtime.client.channels[:channels]
  end

  private

  def self.channel_key
    "channel_count"
  end

  def self.client
    @client ||= Redis.new(url: ENV['REDISTOGO_URL'])
  end
end
