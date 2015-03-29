require 'clockwork'
require './lib/scheduler'

module Clockwork
  every(1.minute, 'frequent.job') { Worker::RealtimePush.perform_async }
  every(7.day, 'cache.clear') { Worker::ESPN.perform_async }
end
