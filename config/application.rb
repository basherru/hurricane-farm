# frozen_string_literal: true

require_relative "boot"

require "rails"
require "pty"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module HurricaneFarm
  class Application < Rails::Application
    config.load_defaults 5.2
    config.eager_load_paths << Rails.root.join("app/services")
    config.active_job.queue_adapter = :sidekiq
  end
end
