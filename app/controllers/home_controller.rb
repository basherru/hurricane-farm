class HomeController < ApplicationController
  http_basic_authenticate_with name: ENV['WEBAPP_USERNAME'], password: ENV['WEBAPP_PASSWORD']

  def index
  end
end