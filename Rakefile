require "rake/testtask"
require "json"
require "tempfile"
require "yaml"
require "pp"
require "dotenv"
require "sequel"

Dotenv.load

task :sequel do
  system "sequel '#{ENV["DB_URL"]}'"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = ["spec/spec_helper"] + 
    FileList['spec/**/*_spec.rb'] + 
    ["spec/feature/feature_helper"] +
    FileList['spec/**/*_feature.rb']
end

task :migrate do
  Sequel.extension :migration
  db = Sequel.connect ENV["DB_URL"]
  Sequel::Migrator.apply db, "db/migrations"
end

task :seed do
  sh "ruby seed/setup.rb"
end

task :cleanse_db do
  require "./lib/database"
  require "./lib/recondb"
  RCDB::User.each { |u| u.destroy }
  RCDB::User.create(name: "admin", password: "password", root: true)
end
