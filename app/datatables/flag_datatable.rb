class FlagDatatable < AjaxDatatablesRails::ActiveRecord
  include ActionView::Helpers::DateHelper

  def view_columns
    @view_columns ||= {
      id:         { source: "Flag.id" },
      created_at: { source: "Flag.created_at" },
      team:       { source: "Flag.team_id" },
      exploit:    { source: "Flag.exploit_id" },
      content:    { source: "Flag.content" },
      status:     { source: "Flag.status" },
      pts:        { source: "Flag.pts" },

    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        created_at: time_ago_in_words(record.created_at),
        team:       record.team&.title || 'Unknown',
        exploit:    record.exploit&.title || 'Unknown',
        content:    record.content,
        status:     record.status,
        pts:        record.pts
      }
    end
  end

  def get_raw_records
    Flag.all
  end

end
