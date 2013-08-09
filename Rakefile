require "rake/testtask"
require "json"
require_relative "lib/recondb"
require_relative "lib/brest_parser"

task :default do
  sh "ruby app.rb"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

def migrate
  Sequel.extension :migration
  db = Sequel.sqlite "db/db.sqlite"
  Sequel::Migrator.apply db, "db/migrations"
end

task :migrate do
  migrate
end

task :clean_json do
  rm_rf "db/json"
  Dir.glob("db/posts/processed/*").each { |file| mv file, "db/posts/unprocessed" }
end

def process_post(post, average)
  average = ReconDatabase::Average.new
  average.save
  ReconDatabase::BrestParser.new(post, average).solves.each do |solve|
    solve.date_added = Time.now.to_i
    average.add_solve(solve)
  end
  mv post, "db/posts/processed"
end

task :import do
  Dir.glob("db/posts/unprocessed/*").each_with_index do |post, average|
    process_post(post, average)
  end
end
