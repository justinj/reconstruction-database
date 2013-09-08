require_relative "../../lib/brest_parser/brest_stats"
require_relative "../../lib/brest_parser/brest_parser"
require_relative "../../lib/puzzle_renamer"

Sequel.migration do
  change do

    create_table :stat_sections do
      primary_key :id
      Integer :solve_id
      String :name
      Float :time
      Integer :position
    end

    create_table :stats do
      primary_key :id
      Integer :stat_section_id
      String :name
      Integer :amount
    end

    from(:solves).exclude(source_content: nil).each do |solve|
      RCDB::BrestParser.new(solve[:source_content]).solves[solve[:position_in_average]][:stats].each.with_index do |(name, values), position|
      time = values["TIME"]
      id = from(:stat_sections).insert(name: name,
                                       time: time,
                                       solve_id: solve[:id],
                                       position: position)
      ["STM", "QTM", "ETM"].select { |metric| values.has_key? metric }.each do |name|
        from(:stats).insert(stat_section_id: id,
                            name: name,
                            amount: values[name])
      end
      end
    end
  end
end
