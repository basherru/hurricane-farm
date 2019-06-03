class HomeController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch('UI_USERNAME'), password: ENV.fetch('UI_PASSWORD')

  def index
  end
end