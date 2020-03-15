# frozen_string_literal: true

require_relative "application"

Rails.application.initialize!
Engine::Reset.call
Engine::Submit::Loop.call
