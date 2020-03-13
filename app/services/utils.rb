# frozen_string_literal: true

module Utils
  extend self

  def to_local_delimiter(content)
    content.gsub("\r\n", "\n")
  end

  def with_numeric_status(params)
    params.to_h.map { |k, v| [k, k == :status ? to_numeric(v) : v] }.to_h
  end

  def get_class(*args)
    args.map(&:to_s).map(&:camelize).join("::").safe_constantize
  end

  def to_normal_time_based_dataset(dataset, rating_size)
    reduce_time_based_dataset(dataset).first(rating_size).to_h
  end

  private

  def reduce_time_based_dataset(dataset)
    dataset.each_with_object({}) do |tuple, memo|
      timestamp = Time.zone.parse(tuple["timestamp"])
      value = tuple["value"]

      memo[timestamp] = value
    end
  end

  def to_numeric(status)
    status == "up" ? 1 : 0
  end
end
