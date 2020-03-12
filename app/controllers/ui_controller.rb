# frozen_string_literal: true

class UiController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch("UI_USERNAME"), password: ENV.fetch("UI_PASSWORD")
end
