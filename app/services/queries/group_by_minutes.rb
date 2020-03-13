# frozen_string_literal: true

class Queries::GroupByMinutes < ApplicationService
  struct :table_name, :options

  DEFAULT_MINUTES_COUNT = 1
  DEFAULT_AGGREGATION = { function: :count, column: "1" }.freeze
  DEFAULT_CONDITIONS = {}.freeze

  def call
    success! query
  end

  private

  def query
    <<-SQL
      SELECT #{select_clause}
      FROM #{table_name}
      #{where_clause}
      GROUP BY timestamp
      ORDER BY timestamp DESC;
    SQL
  end

  def select_clause
    <<-SQL
      #{metric_value_clause},
      #{rounded_timestamp_clause}
    SQL
  end

  def metric_value_clause
    <<-SQL
      #{aggregation[:function]}(#{aggregation[:column]}) AS value
    SQL
  end

  def rounded_timestamp_clause
    <<-SQL
      date_trunc('hour', created_at) + ((#{round_clause}) || ' minutes')::interval AS timestamp
    SQL
  end

  def round_clause
    <<-SQL
      (
        date_part('minute', created_at)::integer / #{minutes_count}::integer
      ) * #{minutes_count}::integer
    SQL
  end

  def where_clause
    return if conditions.blank?

    <<-SQL
      WHERE #{conditions_join_clause}
    SQL
  end

  def conditions_join_clause
    conditions.map { |column, value| [column, value].join(" = ") }.join("\n")
  end

  memoize def minutes_count
    options.fetch(:minutes_count, DEFAULT_MINUTES_COUNT)
  end

  memoize def aggregation
    options.fetch(:aggregation, DEFAULT_AGGREGATION)
  end

  memoize def conditions
    options.fetch(:conditions, DEFAULT_CONDITIONS)
  end
end
