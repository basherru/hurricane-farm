# frozen_string_literal: true

class Charts::GetData < ApplicationService
  CHART_TYPES = %i[temporal partition].freeze
  CHART_TYPE_STRATEGY = { temporal: :line, partition: :pie }.freeze
  CHART_MODELS = %i[team exploit].freeze
  CHART_METRICS = %i[flags points].freeze

  def call
    success! charts_data
  end

  private

  def charts_data
    charts_cartesian.each_with_object({}) do |args, data|
      type, = args
      strategy = CHART_TYPE_STRATEGY.fetch(type)
      bucket = "#{strategy}_charts".to_sym

      data[bucket] = wrap(*args)
    end
  end

  def wrap(*args)
    {
      title: compose_title(*args.map(&:to_s)),
      data: get_data(*args),
    }
  end

  def compose_title(type, model, metric)
    "#{type.humanize} #{model.humanize}s Statistics (#{metric.humanize})"
  end

  def get_data(type, model, metric)
    Charts::QueryDataset.call(type, model, metric).response
  end

  def charts_cartesian
    CHART_TYPES.product(CHART_MODELS, CHART_METRICS)
  end
end
