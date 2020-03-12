# frozen_string_literal: true

class Charts::QueryDataset::Partition::Flags < Charts::QueryDataset::Partition
  private

  def dataset
    joined_dataset.order("count(1) desc").count.first(rating_size).to_h
  end
end
