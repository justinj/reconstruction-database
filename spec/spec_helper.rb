require "minitest/autorun"
require "timecop"

require_relative "../lib/recondb"

Sequel.extension :migration
Sequel::Model.db = Sequel.sqlite
Sequel::Migrator.apply Sequel::Model.db, "db/migrations"

def fixture(filename)
  "spec/fixtures/#{filename}"
end
