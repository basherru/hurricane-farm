class HomeController < ApplicationController
  http_basic_authenticate_with name: ENV['UI_USERNAME'], password: ENV['UI_PASSWORD']

  def index
  end
end