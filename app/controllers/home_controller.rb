class HomeController < UiController
  def index
    @charts = DashboardChartsService.data
  end
end