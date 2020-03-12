# frozen_string_literal: true

module Scopes::FlagsPartition
  extend ActiveSupport::Concern

  included do
    define_singleton_method :model do
      name.underscore.to_sym
    end

    define_singleton_method :statistics_source do
      Flag.joins(model).group(:title)
    end

    scope :flags_partition, lambda {
      statistics_source.order("count(1) desc")
        .count
        .first(10)
        .to_h
    }

    scope :points_partition, lambda {
      statistics_source.order("sum(pts) desc")
        .sum(:pts)
        .first(10)
        .to_h
    }

    private_class_method :model, :statistics_source
  end
end
