class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.group_by_minutes(count, aggregation: {}, where_clause: {})
    query = <<-SQL
      SELECT #{aggregation[:type]}(#{aggregation[:field]}),
        date_trunc('hour', created_at)
          + (
            ((date_part('minute', created_at)::integer / #{count}::integer) * #{count}::integer)
              || ' minutes'
            )::interval AS timestamp
      FROM #{table_name}
      #{
        if where_clause.size > 0
          key = where_clause.keys.first
          "WHERE #{key} = #{where_clause[key]}"
        end
      }
      #{
        if where_clause.size > 1
          where_clause.keys[1..].map { |key| "  AND #{key} = #{where_clause[key]}" }.join("\n".ljust(7, ' '))
        end
      }
      GROUP BY timestamp
      ORDER BY timestamp ASC;
    SQL
    ActiveRecord::Base.connection
      .execute(query)
      .reduce({}) do |product, tuple|
      product[DateTime.parse(tuple['timestamp'])] = tuple[aggregation[:type].to_s]
      product
    end
  end
end
