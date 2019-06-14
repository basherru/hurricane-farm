module Helpers
  module GroupableByMinutes
    def group_by_minutes(count, options)
      query = <<-SQL
        SELECT #{options.dig(:aggregation, :type)}(#{options.dig(:aggregation, :field)}),
        #{trunc_clause(count)}
        FROM #{table_name}
        #{where_clause(options.dig(:where_clause))}
        GROUP BY timestamp
        ORDER BY timestamp DESC;
      SQL
      ActiveRecord::Base.connection
                        .execute(query)
                        .each_with_object({}) do |tuple, product|
                          product[Time.zone.parse(tuple['timestamp'])] = tuple[options.dig(:aggregation, :type).to_s]
                          product
                        end
    end

    private

    def trunc_clause(count)
      <<-TRUNC_CLAUSE
        date_trunc('hour', created_at)
            + (
              ((date_part('minute', created_at)::integer / #{count}::integer) * #{count}::integer)
                || ' minutes'
              )::interval AS timestamp
      TRUNC_CLAUSE
    end

    def where_clause(where_clause)
      <<-WHERE_CLAUSE
        #{if where_clause.size.positive?
            key = where_clause.keys.first
            "WHERE #{key} = #{where_clause[key]}"
          end}
        #{if where_clause.size > 1
            where_clause.keys[1..]
                        .map { |field| "  AND #{field} = #{where_clause[field]}" }
                        .join("\n")
          end}
      WHERE_CLAUSE
    end
  end
end