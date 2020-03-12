# frozen_string_literal: true

class Charts::QueryDataset::Partition::Points < Charts::QueryDataset::Partition
  private

  def dataset
    joined_dataset.order("sum(pts) desc").sum(:pts).first(rating_size).to_h
  end
end
