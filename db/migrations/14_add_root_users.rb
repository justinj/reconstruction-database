Sequel.migration do
  change do
    add_column :users, :root, Integer
  end
end
