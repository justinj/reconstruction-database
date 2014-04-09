Sequel.migration do
  change do
    add_column :searches, :ip_hash, String
  end
end
