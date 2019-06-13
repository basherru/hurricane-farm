class DashboardChartsService
  def self.data
    {
      line_charts: [
        {
          title: 'Temporal Teams Statistics (Flags)',
          data:  Team.temporal_flags
        },
        {
          title: 'Temporal Exploits Statistics (Flags)',
          data:  Exploit.temporal_flags
        },
        {
          title: 'Temporal Teams Statistics (Points)',
          data:  Team.temporal_points
        },
        {
          title: 'Temporal Exploits Statistics (Points)',
          data:  Exploit.temporal_points
        }
      ],
      pie_charts: [
        {
          title: 'Teams Statistics (Flags)',
          data: Team.flags_partition
        },
        {
          title: 'Exploits Statistics (Flags)',
          data: Exploit.flags_partition
        },
        {
          title: 'Teams Statistics (Points)',
          data: Team.points_partition
        },
        {
          title: 'Exploits Statistics (Points)',
          data: Exploit.points_partition
        }
      ]
    }
  end
end