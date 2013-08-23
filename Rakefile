require "rake/testtask"
require "json"
require "tempfile"
require "yaml"
require "pp"
require "dotenv"

Dotenv.load

task :sequel do
  system "sequel '#{ENV["DB_URL"]}'"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['spec/*_spec.rb']
end

task :migrate do
  Sequel.extension :migration
  db = Sequel.sqlite ENV["DB_URL"]
  Sequel::Migrator.apply db, "db/migrations"
end
