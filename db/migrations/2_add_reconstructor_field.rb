Sequel.migration do
  change do
    add_column :solves, :reconstructor, String
    from(:solves).update(:reconstructor => "Brest")
  end
end
