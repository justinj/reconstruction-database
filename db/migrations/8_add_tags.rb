Sequel.migration do
  change do
    create_table(:tags) do
      primary_key :id
      String :name
    end

    create_table(:solves_tags) do
      Integer :solve_id
      Integer :tag_id
      primary_key [:solve_id, :tag_id]
    end
  end
end
