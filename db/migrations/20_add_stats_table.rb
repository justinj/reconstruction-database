require_relative "../../lib/brest_parser/brest_stats"
require_relative "../../lib/brest_parser/brest_parser"
require_relative "../../lib/puzzle_renamer"

Sequel.migration do
  change do

#     create_table :stats do
#       primary_key :id
#       Integer :solve_id
#       String :name
#       Float :time
#       Float :stm
#       Float :etm
#       Integer :position
#     end

#     from(:solves).exclude(source_content: nil).each do |solve|

#       begin
#         RCDB::BrestParser.new(solve[:source_content]).solves[solve[:position_in_average]][:stats].each.with_index do |(name, values), position|
#         time = values["Time"] 
#         stm = values["STM"]
#         etm = values["ETM"]
#         from(:stats).insert(name: name,
#                             time: time,
#                             stm: stm,
#                             etm: etm,
#                             solve_id: solve[:id],
#                             position: position,
#                            )
#         end
#       rescue
#         # If something goes wrong, this stat did not parse properly, so we'll leave it blank.
#       end
#     end
  end

end
