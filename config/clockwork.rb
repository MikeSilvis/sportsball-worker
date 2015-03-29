require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  #every(1.minute, 'frequent.job') { RealtimePush.perform_async if Realtime::Channel.any? }
  #every(7.day, 'cache.clear') { Precache.perform_async }
end
