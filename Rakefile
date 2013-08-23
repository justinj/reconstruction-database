require "rake/testtask"
require "json"
require "tempfile"
require "yaml"
require "pp"

task :sequel do
  raise "Fix this for the new DB scheme"
  system "sequel 'sqlite://db/db.sqlite'"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['spec/*_spec.rb']
end

task :migrate do
  raise "Fix this for the new DB scheme"
  Sequel.extension :migration
  db = Sequel.sqlite "db/db.sqlite"
  Sequel::Migrator.apply db, "db/migrations"
end
