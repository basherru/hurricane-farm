# frozen_string_literal: true

class Charts::QueryDataset::Temporal < Charts::QueryDataset
  builds { |_, model, _| Utils.get_class(name, model) }

  DEFAULT_TITLE = "Unknown"

  private

  # @!method aggregation, model_dataset

  def dataset
    model_dataset.map { |record| wrap(record) }
  end

  def wrap(record)
    {
      name: record.title || DEFAULT_TITLE,
      data: Utils.to_normal_time_based_dataset(query_for(record), rating_size),
    }
  end

  memoize def model
    Utils.get_class(super)
  end

  memoize def model_id
    "#{model.name}_id"
  end

  def query_for(record)
    Queries::GroupByMinutes.call(
      :flags,
      aggregation: aggregation,
      conditions: { model_id => record.id },
    ).response
  end
end
