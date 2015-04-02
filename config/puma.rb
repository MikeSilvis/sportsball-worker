environment ENV['RACK_ENV']
workers 1
threads 1, 1
preload_app!

on_worker_boot do
  @sidekiq_pid   ||= spawn("bundle exec sidekiq -r ./lib/scheduler.rb")
  @clockwork_pid ||= spawn("bundle exec clockwork config/clockwork.rb")
end
