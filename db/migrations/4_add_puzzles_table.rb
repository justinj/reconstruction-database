Sequel.migration do
  up do
    create_table :puzzles do
      primary_key :id

      String :name
    end

    puzzles = from(:solves).select(:puzzle).group_by(:puzzle).map { |res| res[:puzzle] }
    puzzles.each do |puzzle|
      from(:puzzles).insert(name: puzzle)
    end

    alter_table :solves do
      add_foreign_key :puzzle_id, :puzzles
    end

    from(:puzzles).select(:id, :name).each do |puzzle|
      from(:solves).where(puzzle: puzzle[:name]).update(puzzle_id: puzzle[:id])
    end

    drop_column :solves, :puzzle
  end

  down do
    add_column :solves, :puzzle, String
    drop_column :solves, :puzzle_id
    drop_table :puzzles
  end
end
