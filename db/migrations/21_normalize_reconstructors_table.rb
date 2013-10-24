Sequel.migration do
  up do
    create_table :reconstructors do
      primary_key :id
      String :name
    end

    add_column :solves, :reconstructor_id, Integer

    reconstructors = from(:solves).select(:reconstructor).distinct

    reconstructors.map { |r| r[:reconstructor] }.each do |reconstructor|
      id = from(:reconstructors).insert(name: reconstructor)
      from(:solves).where(reconstructor: reconstructor).update(reconstructor_id: id)
    end

    drop_column :solves, :reconstructor
  end
end
