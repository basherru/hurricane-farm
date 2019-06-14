class HomeController < UiController
  def index
    @charts = DashboardChartsService.call
  end
end