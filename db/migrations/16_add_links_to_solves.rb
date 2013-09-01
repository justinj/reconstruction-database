Sequel.migration do
  change do
    add_column :averages, :source_url, String
  end
end
