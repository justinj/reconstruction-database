Sequel.migration do
  change do
    add_column :puzzles, :delimiter, String
  end
end
