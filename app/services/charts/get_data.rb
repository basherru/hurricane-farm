class Charts::GetData < ApplicationService
  CHART_TYPES = %i[temporal partition].freeze
  CHART_TYPE_STRATEGY = { temporal: :line, partition: :pie }.freeze
  CHART_ENTITIES = %i[team exploit].freeze
  CHART_METRICS = %i[flags points].freeze

  def call
    success! charts_data
  end

  private

  def charts_data
    charts_cartesian.each_with_object({}) do |args, data|
      type, _, _ = args
      strategy = CHART_TYPE_STRATEGY.fetch(type)
      bucket = "#{strategy}_charts".to_sym

      data[bucket] = wrap(*args)
    end
  end

  def wrap(type, entity, metric)
    {
      title: title_template(type, entity, metric),
      data: metric_value(type, entity, metric),
    }
  end

  def title_template(type, entity, metric)
    "#{type.humanize} #{entity.humanize}s Statistics (#{metric.humanize})"
  end

  def metric_value(type, entity, metric)
    metric_accessor_name = [metric, type].join("_")

    entity.camelize.constantize.public_send(metric_accessor_name)
  end

  memoize def charts_cartesian
    CHART_TYPES.product(CHART_ENTITIES, CHART_METRICS)
  end
end