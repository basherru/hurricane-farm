class HomeController < UiController
  def index
    @temporal_teams_flags_data = Team.temporal_statistics_flags
    @temporal_exploits_flags_data = Exploit.temporal_statistics_flags
    @temporal_teams_points_data = Team.temporal_statistics_points
    @temporal_exploits_points_data = Exploit.temporal_statistics_points
  end
end