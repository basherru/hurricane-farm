class Team < ApplicationRecord
  has_and_belongs_to_many :exploits
  has_many :flags

  validates :title, :host, presence: true

  enum status: %i[active inactive]

  scope :temporal_statistics_flags, ->() do
    all.sort_by { |team| -team.flags.count }
      .first(10)
      .map do |team|
        {
          name: team.title || "Unknown",
          data: Flag.group_by_minutes(10, aggregation: { type: :count, field: '1' }, where_clause: { team_id: team.id }).first(10).to_h
        }
      end
  end

  scope :temporal_statistics_points, ->() do
    all.sort_by { |team| -team.flags.map(&:pts).inject(:+) }
      .first(10)
      .map do |team|
        {
          name: team.title || "Unknown",
          data: Flag.group_by_minutes(10, aggregation: { type: :sum, field: :pts }, where_clause: { team_id: team.id }).first(10).to_h
        }
      end
  end
end
