Sequel.migration do
  change do
    create_table :queries do
      primary_key :id
      Integer :timestamp
      String :query
      String :ip_hash
    end
  end
end
