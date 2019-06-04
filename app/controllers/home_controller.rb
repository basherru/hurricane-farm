class HomeController < UiController
  def index
    @charts = [
      {
        type: :line,
        title: 'Temporal Teams Statistics',
        data: Team.all.map do |team|
          {
            name: team.title || "Unknown",
            data: team.flags.group_by_minute(:created_at).count
          }
        end
      },
      {
        type: :pie,
        title: 'Flags By Status',
        data: Flag.group(:status).count
      },
      {
        type: :pie,
        title: 'Flags By Exploit',
        data: Flag.joins(:exploit).group(:title).count
      },
      {
        type: :pie,
        title: 'Flags By Teams',
        data: Flag.joins(:team).group(:title).count
      }
    ]
  end
end