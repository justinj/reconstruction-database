Sequel.migration do
  up do
    drop_column :solves, :notes
  end

  down do
    add :solves, :notes, String
  end
end
