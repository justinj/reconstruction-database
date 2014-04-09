Sequel.migration do
  change do
    create_table :searches do
      primary_key :id
      Integer :timestamp
      String :solver
      String :competition
      String :puzzle
      String :time_specifier
      String :time_value
      String :tags
    end
  end
end
