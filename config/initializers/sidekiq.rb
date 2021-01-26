# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{ENV.fetch("REDIS_URL", "localhost:6379")}/1",
    password: ENV["REDIS_PASSWORD"],
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{ENV.fetch("REDIS_URL", "localhost:6379")}/1",
    password: ENV["REDIS_PASSWORD"],
  }
end
