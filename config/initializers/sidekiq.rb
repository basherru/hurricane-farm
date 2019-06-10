Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV.fetch('REDIS_URL') { 'localhost:6379' }}/1", password: ENV.fetch('REDIS_PASSWORD') { nil } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV.fetch('REDIS_URL') { 'localhost:6379' }}/1", password: ENV.fetch('REDIS_PASSWORD') { nil } }
end