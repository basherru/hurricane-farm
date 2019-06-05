class TeamDatatable < AjaxDatatablesRails::ActiveRecord
  include Chartkick::Helper
  include Rails.application.routes.url_helpers

  def view_columns
    @view_columns ||= {
      id:        { source: "Team.id" },
      title:     { source: "Team.title" },
      host:      { source: "Team.host" },
      exploits:  { orderable: false, searchable: false },
      flags:     { orderable: false, searchable: false },
      points:    { orderable: false, searchable: false },
      status:    { source: "Team.status" },
      edit_link: { orderable: false, searchable: false }
    }
  end

  def data
    records.map do |record|
      {
        id:        record.id,
        title:     record.title,
        host:      record.host,
        exploits:  exploits_map(record),
        flags:     line_chart(flags_chart_data(record)),
        points:    line_chart(points_chart_data(record)),
        status:    record.status,
        edit_link: edit_team_path(record)
      }
    end
  end

  def get_raw_records
    Team
  end

  def flags_chart_data(record)
    Flag
      .group_by_minutes(1, aggregation: { type: :count, field: '1' }, where_clause: { team_id: record.id })
      .first(10)
      .to_h
  end

  def points_chart_data(record)
    Flag
      .group_by_minutes(1, aggregation: { type: :sum, field: :pts }, where_clause: { team_id: record.id })
      .first(10)
      .to_h
  end

  def exploits_map(record)
    Exploit.order('id ASC').map do |exploit|
      if record.exploits.include?(exploit)
        1
      else
        0
      end
    end
  end
end
