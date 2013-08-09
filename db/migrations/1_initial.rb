Sequel.migration do
  change do
    create_table :averages do
      primary_key :id
    end

    create_table :solves do
      primary_key :id
      Integer :average_id

      String :scramble
      String :solution
      String :solver
      String :competition
      String :puzzle
      String :penalty

      Float :time
      String :youtube

      String :source
      String :source_content

      Time :date_added
      String :reconstructor
    end
  end
end
