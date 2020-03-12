# frozen_string_literal: true

Rails.application.configure do
  ActiveRecord::Base.include_root_in_json = true

  config.cache_classes = true

  config.eager_load = false

  config.public_file_server.enabled = false

  config.consider_all_requests_local = true

  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :test

  config.active_support.deprecation = :stderr
end
