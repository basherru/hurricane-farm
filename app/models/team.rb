class Team < ApplicationRecord
  has_and_belongs_to_many :exploits
  has_many :flags

  validates :title, :host, presence: true

  enum status: %i[inactive active]

  scope :temporal_flags, ->() do
    all.sort_by { |team| -team.flags.count }
      .first(10)
      .map do |team|
        {
          name: team.title || "Unknown",
          data: Flag.group_by_minutes(10, aggregation: { type: :count, field: '1' }, where_clause: { team_id: team.id }).first(10).to_h
        }
      end
  end

  scope :temporal_points, ->() do
    all.sort_by { |team| -team.flags.map(&:pts).reduce(0, :+) }
      .first(10)
      .map do |team|
        {
          name: team.title || "Unknown",
          data: Flag.group_by_minutes(10, aggregation: { type: :sum, field: :pts }, where_clause: { team_id: team.id }).first(10).to_h
        }
      end
  end

  scope :flags_partition, ->() do
    Flag.joins(:team).group(:title).order('count(1) desc').count.first(10).to_h
  end

  scope :points_partition, ->() do
    Flag.joins(:team).group(:title).order('sum(pts) desc').sum(:pts).first(10).to_h
  end
end
