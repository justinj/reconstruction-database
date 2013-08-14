Sequel.migration do
  up do
    create_table :competitions do
      primary_key :id

      String :name
    end

    competitions = from(:solves).select(:competition).group_by(:competition).map { |res| res[:competition] }
    competitions.each do |competition|
      from(:competitions).insert(name: competition)
    end

    alter_table :solves do
      add_foreign_key :competition_id, :competitions
    end

    from(:competitions).select(:id, :name).each do |competition|
      from(:solves).where(competition: competition[:name]).update(competition_id: competition[:id])
    end

    drop_column :solves, :competition
  end

  down do
    add_column :solves, :competition, String
    drop_column :solves, :competition_id
    drop_table :competitions
  end
end
