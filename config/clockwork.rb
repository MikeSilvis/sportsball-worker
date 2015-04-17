require 'clockwork'
require './lib/scheduler'

module Clockwork
  every(15.seconds, 'frequent.job') { Worker::RealtimePush.perform_async }
  every(1.day, 'cache.clear', at: '07:30', tz: 'UTC') { Worker::ESPN.perform_async }
end
