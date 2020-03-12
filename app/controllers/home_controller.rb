# frozen_string_literal: true

class HomeController < UiController
  def index
    @charts = Charts::GetData.call
  end
end
