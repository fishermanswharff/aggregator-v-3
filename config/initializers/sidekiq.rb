Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 15
  config.redis = { url: 'redis://localhost:6379/1' }
end
