module Scopes
  module FlagsTemporal
    extend ActiveSupport::Concern

    included do
      define_singleton_method :model_id do
        "#{name}_id".underscore.to_sym
      end

      define_singleton_method :flags_by_ten_minutes do |record, aggregation|
        Flag.group_by_minutes(10, aggregation: aggregation,
                                  where_clause: { model_id => record.id }).first(10).to_h
      end

      define_singleton_method :statistics_object do |record, aggregation|
        {
          name: record.title || "Unknown",
          data: flags_by_ten_minutes(record, aggregation)
        }
      end

      scope :flags_temporal, lambda {
        all.sort_by { |record| -record.flags.count }
           .first(10)
           .map { |record| statistics_object(record, type: :count, field: '1') }
      }

      scope :points_temporal, lambda {
        all.sort_by { |record| -record.flags.map(&:pts).reduce(0, :+) }
           .first(10)
           .map { |record| statistics_object(record, type: :sum, field: :pts) }
      }

      private_class_method :model_id, :flags_by_ten_minutes, :statistics_object
    end
  end
end