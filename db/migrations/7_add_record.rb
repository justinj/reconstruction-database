Sequel.migration do
  change do
    add_column :solves, :record, String
    add_column :averages, :record, String
  end
end
