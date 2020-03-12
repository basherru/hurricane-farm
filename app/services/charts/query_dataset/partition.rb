# frozen_string_literal: true

class Charts::QueryDataset::Partition < Charts::QueryDataset
  builds { |_, model, _| Utils.get_class(name, model) }

  private

  # @!method dataset

  def joined_dataset
    Flag.joins(model).group(:title)
  end
end
