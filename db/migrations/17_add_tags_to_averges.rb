Sequel.migration do
  change do
    create_table(:averages_tags) do
      Integer :average_id
      Integer :tag_id
      primary_key [:average_id, :tag_id]
    end
  end
end
