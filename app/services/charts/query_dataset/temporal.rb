# frozen_string_literal: true

class Charts::QueryDataset::Temporal < Charts::QueryDataset
  builds { |_, _, metric| Utils.get_class(name, metric) }

  DEFAULT_TITLE = "Unknown"

  private

  # @!method aggregation, model_dataset

  def dataset
    model_dataset.map { |record| wrap(record) }
  end

  def wrap(record)
    {
      name: record.title || DEFAULT_TITLE,
      data: Utils.to_normal_time_based_dataset(dataset_for(record), rating_size),
    }
  end

  def dataset_for(record)
    connection.execute(query_for(record))
  end

  memoize def model
    Utils.get_class(super)
  end

  memoize def model_id
    "#{model.name.downcase}_id"
  end

  def query_for(record)
    Queries::GroupByMinutes.call(
      :flags,
      minutes_count: 10,
      aggregation: aggregation,
      conditions: { model_id => record.id },
    ).response
  end
end
