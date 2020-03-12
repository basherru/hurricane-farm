# frozen_string_literal: true

class Api::ApiController < ApplicationController
  before_action :authenticate_request
  skip_before_action :verify_authenticity_token

  private

  def authenticate_request
    head :unauthorized unless api_key_matches?
  end

  def api_key_matches?
    request.headers["HTTP_API_KEY"] == ENV.fetch("API_KEY")
  end
end
