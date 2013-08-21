Sequel.migration do
  up do
    rename_column :solves, :record, :single_record
    rename_column :averages, :record, :average_record
    [:solver_id, :puzzle_id, :competition_id].each do |column|
      add_column :averages, column, Integer

      from(:averages).each do |average|
        solve = from(:solves).where(average_id: average[:id]).first
        next unless solve
        solver_id = solve[column]
        from(:averages).where(id: average[:id])
          .update(column => solver_id)
      end

      drop_column :solves, column
    end
  end

  down do
    rename_column :solves, :single_record, :record
    [:solver_id, :puzzle_id, :competition_id].each do |column|
      add_column :solves, column, Integer
      drop_column :averages, column
    end
  end
end
