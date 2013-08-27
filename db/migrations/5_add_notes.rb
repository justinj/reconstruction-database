Sequel.migration do
  change do
    add_column :solves, :notes, String
    from(:averages).each do |average|
      from(:solves).where(source: "brest_post", average_id: average[:id]).each_with_index do |solve, i|
        notes = RCDB::BrestParser.new(solve[:source_content]).solves.map { |solve| solve[:notes] }
        id = solve[:id]
        from(:solves).where(id: solve[:id]).update(notes: notes[i])
      end
    end
  end
end
