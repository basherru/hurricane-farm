module Api
  class ApiController < ApplicationController
    before_action :authenticate_request

    private

    def authenticate_request
      head :unauthorized unless request.headers['API_KEY'] == ENV['API_KEY']
    end
  end
end