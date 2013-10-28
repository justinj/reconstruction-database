Sequel.migration do
  change do
    add_column :puzzles, :formatting_type, String
    from(:puzzles).update(formatting_type: "speed")

    add_column :solves, :canonical_solution, String
  end
end
