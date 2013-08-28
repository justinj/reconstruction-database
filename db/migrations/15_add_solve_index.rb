Sequel.migration do
  change do
    add_column :solves, :position_in_average, Integer
    from(:averages).each do |average|
      solves = from(:solves).where(average_id: average[:id])
      lowest = solves.first[:id]
      solves.each do |solve|
        from(:solves).where(id: solve[:id]).update(position_in_average: solve[:id] - lowest)
      end
    end
  end
end
