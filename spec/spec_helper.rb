require "logger"

require 'coveralls'
Coveralls.wear!

require "minitest/autorun"
require "mocha/setup"
require "timecop"
require "sequel"

require "sequel-fixture"

ENV["RACK_ENV"] = "test"

Sequel::Fixture.path = File.join(File.dirname(__FILE__), "fixtures")

Sequel.extension :migration
Sequel::Model.db = DB = Sequel.sqlite
Sequel::Migrator.apply Sequel::Model.db, "db/migrations"

# Sequel::Model.db.loggers << Logger.new($stdout)

require_relative "../lib/recondb"

def fixture_post(filename)
  File.read("spec/fixtures/#{filename}")
end

def destroy_db
  DB.tables.each{|table| Sequel::Model.db.from(table).delete}
end
