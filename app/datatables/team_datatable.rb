# frozen_string_literal: true

class TeamDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: "Team.id" },
      title: { source: "Team.title" },
      host: { source: "Team.host" },
      exploits: { orderable: false, searchable: false },
      flags: { orderable: false, searchable: false },
      points: { orderable: false, searchable: false },
      status: { source: "Team.status" },
      edit_link: { orderable: false, searchable: false },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        host: record.host,
        exploits: map_exploits_presence_for(record),
        flags: query_to_line_chart(flags_query_for(record)),
        points: query_to_line_chart(points_query_for(record)),
        status: record.status,
        edit_link: edit_team_path(record),
      }
    end
  end

  def get_raw_records
    Team.all
  end

  private

  def flags_query_for(record)
    Queries::GroupByMinutes.call(
      :flags,
      aggregation: { function: :count, column: "1" },
      conditions: { team_id: record.id },
    ).response
  end

  def points_query_for(record)
    Queries::GroupByMinutes.call(
      :flags,
      aggregation: { function: :sum, column: :pts },
      conditions: { team_id: record.id },
    ).response
  end

  def map_exploits_presence_for(record)
    exploits_dataset.map { |exploit| exploit.in?(record.exploits) ? 1 : 0 }
  end

  def exploits_dataset
    Exploit.order("id ASC")
  end
end
