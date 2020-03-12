# frozen_string_literal: true

class Charts::QueryDataset::Temporal::Flags < ApplicationService
  private

  def model_dataset
    model.all.sort_by { |record| -record.flags.count }.first(rating_size)
  end

  def aggregation
    { function: :count, column: "1" }
  end
end
