Sequel.migration do
  change do
    add_column :solvers, :wca_id, String
  end
end
