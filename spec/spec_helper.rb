require "minitest/autorun"
require "mocha/setup"
require "timecop"
require "sequel"

require_relative "fixtures/fixture_data"

Sequel.extension :migration
Sequel::Model.db = Sequel.sqlite
Sequel::Migrator.apply Sequel::Model.db, "db/migrations"

require_relative "../lib/recondb"

def fixture(filename)
  File.read("spec/fixtures/#{filename}")
end
