require "pry"
require "minitest/autorun"
require "sequel"
require "sinatra"
require "sinatra/sequel"

Sequel.extension :migration
db = Sequel.sqlite
Sequel::Migrator.apply db, "db/migrations"
Sequel::Model.db = db

class Solve < Sequel::Model
end

class SolveTest < Minitest::Test
end
