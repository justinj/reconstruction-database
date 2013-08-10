require "minitest/autorun"

require_relative "../lib/recondb"

Sequel.extension :migration
Sequel::Model.db = Sequel.sqlite
Sequel::Migrator.apply Sequel::Model.db, "db/migrations"

require_relative "../lib/brest_parser"
require_relative "../lib/solve"
require_relative "../lib/form/dropdown"
require_relative "../helpers/view_helpers"

def fixture(filename)
  "spec/fixtures/#{filename}"
end
