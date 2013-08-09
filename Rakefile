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

def handle_post(post, average)
  average = ReconDatabase::Average.new
  average.save
  ReconDatabase::BrestParser.new(post, average).solves.each do |solve|
    solve.date_added = Time.now.to_i
    average.add_solve(solve)
  end
  mv post, "db/posts/processed"
end

task :reimport do
  unprocessed_posts = Dir.glob("db/posts/unprocessed/*")
  mkdir "db/json" unless Dir.exist? "db/json"
  unprocessed_posts.each_with_index { |post, average| handle_post(post, average) }
end
