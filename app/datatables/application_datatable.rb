# frozen_string_literal: true

class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  include Chartkick::Helper
  include Memery
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::DateHelper

  private

  def query_to_line_chart(query)
    dataset = query_to_normal_dataset(query)

    line_chart(dataset)
  end

  def query_to_normal_dataset(query)
    dataset = connection.execute(query)

    Utils.to_normal_time_based_dataset(dataset, rating_size)
  end

  def connection
    ActiveRecord::Base.connection
  end

  memoize def rating_size
    config.datatable_rating_size
  end
end
