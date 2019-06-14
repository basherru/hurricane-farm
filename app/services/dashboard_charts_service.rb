class DashboardChartsService
  def self.call
    data = { line_charts: [], pie_charts: [] }.with_indifferent_access

    charts_types_strategy = { temporal: :line, partition: :pie }.with_indifferent_access

    %w[temporal partition].each do |group_type|
      %w[flags points].each do |measure|
        %w[team exploit].each do |record|
          strategy = charts_types_strategy[group_type]
          bucket = "#{strategy}_charts"
          container = {
            title: "#{group_type.humanize} #{record.humanize}s Statistics (#{measure.humanize})",
            data:  record.camelize.constantize.public_send("#{measure}_#{group_type}")
          }
          data[bucket] << container unless container[:data].empty?
        end
      end
    end

    data
  end
end