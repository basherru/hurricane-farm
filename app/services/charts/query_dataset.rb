# frozen_string_literal: true

class Charts::QueryDataset < ApplicationService
  struct :type, :model, :metric

  builds { |type, _, _| Utils.get_class(name, type) }

  def call
    success! dataset
  end

  private

  # @!method dataset, model

  memoize def rating_size
    config.datatable_rating_size
  end

  def connection
    ActiveRecord::Base.connection
  end
end
