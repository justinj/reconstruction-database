Sequel.migration do
  change do
    add_column :competitions, :code, String
  end
end
