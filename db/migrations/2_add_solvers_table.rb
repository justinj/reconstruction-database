Sequel.migration do
  up do
    create_table :solvers do
      primary_key :id

      String :name
    end

    solvers = from(:solves).select(:solver).group_by(:solver).map { |res| res[:solver] }
    solvers.each do |solver|
      from(:solvers).insert(name: solver)
    end

    alter_table :solves do
      add_foreign_key :solver_id, :solvers
    end

    from(:solves).select(:id, :solver).each do |solve|
      id = from(:solvers).select(:id).where(name: solve[:solver]).first[:id]
      from(:solves).where(id: solve[:id]).update(solver_id: id)
    end

    drop_column :solves, :solver
  end

  down do
    add_column :solves, :solver, String
    drop_column :solves, :solver_id
    drop_table :solvers
  end
end
