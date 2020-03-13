# frozen_string_literal: true

class Charts::QueryDataset::Temporal::Team < Charts::QueryDataset::Temporal
  private

  def model_dataset
    model.all.sort_by { |record| -record.flags.count }.first(rating_size)
  end
end
