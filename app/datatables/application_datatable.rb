# frozen_string_literal: true

class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  include Chartkick::Helper
  include Memery
  include Rails.application.routes.url_helpers

  private

  def query_to_line_chart(query)
    dataset = query_to_normal_dataset(query)

    line_chart(dataset)
  end

  def query_to_normal_dataset(query)
    dataset = connection.execute(query)

    normalize_dataset(dataset)
  end

  def normalize_dataset(dataset)
    reduce_dataset(dataset).first(rating_size).to_h
  end

  def reduce_dataset(dataset)
    dataset.each_with_object({}) do |tuple, memo|
      timestamp = Time.zone.parse(tuple["timestamp"])
      value = tuple["value"]

      memo[timestamp] = value
    end
  end

  def connection
    ActiveRecord::Base.connection
  end

  memoize def rating_size
    App.config.datatable_rating_size
  end
end
