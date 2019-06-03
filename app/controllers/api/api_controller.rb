module Api
  class ApiController < ApplicationController
    before_action :authenticate_request
    skip_before_action :verify_authenticity_token

    private

    def authenticate_request
      head :unauthorized unless request.headers['HTTP_API_KEY'] == ENV.fetch('API_KEY')
    end
  end
end