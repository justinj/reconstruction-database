Sequel.migration do
  change do
    add_column :averages, :visible, Integer
    from(:averages).update(visible: true)
  end
end
