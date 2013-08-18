require "minitest/autorun"
require "mocha/setup"
require "timecop"

require_relative "../lib/recondb"
require_relative "fixtures/fixture_data"

def setup_db
  Sequel.extension :migration
  Sequel::Model.db = Sequel.sqlite
  Sequel::Migrator.apply Sequel::Model.db, "db/migrations"

  [ReconDatabase::Tag, ReconDatabase::Average, ReconDatabase::Solve, ReconDatabase::Solver, ReconDatabase::Competition, ReconDatabase::Puzzle].each do |model|
    model.db = Sequel::Model.db 
  end
  ReconDatabase::seed_db
end

setup_db


def fixture(filename)
  File.read("spec/fixtures/#{filename}")
end
