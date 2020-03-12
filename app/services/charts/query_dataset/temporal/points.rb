# frozen_string_literal: true

class Charts::QueryDataset::Temporal::Points < ApplicationService
  private

  def model_dataset
    model.all.sort_by { |record| -points_sum_for(record) }.first(rating_size)
  end

  def aggregation
    { function: :sum, column: :pts }
  end

  def points_sum_for(record)
    record.flags.map(&:pts).reduce(0, :+)
  end
end
