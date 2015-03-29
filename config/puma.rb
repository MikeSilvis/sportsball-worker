environment ENV['RACK_ENV']
workers 5
threads 1, 3
preload_app!

on_worker_boot do
  @sidekiq_pid   ||= spawn("bundle exec sidekiq -r ./lib/scheduler.rb")
  #@clockwork_pid ||= spawn("bundle exec clockwork -r ./lib/scheduler.rb")
end
