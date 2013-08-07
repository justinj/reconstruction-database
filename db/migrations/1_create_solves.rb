Sequel.migration do
  change do
    create_table :solves do
      primary_key :id
      String :scramble
      String :solution
      String :solver
      Float :time

      String :youtube
      String :competition
      String :puzzle

      String :original_post
      Integer :average

      Time :date_added
    end
  end
end
