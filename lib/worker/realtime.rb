module Realtime
  Pusher.url = ENV['JUMBOTRON_PUSHER_URL']

  def self.client
    @client ||= Pusher
  end
end

require_relative './realtime/channel'
require_relative './realtime/checker'
require_relative './realtime/publisher'
