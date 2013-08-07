require "rake/testtask"
require_relative "recondb"

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
end

def process_all_posts
  unprocessed_posts = Dir.glob("db/posts/unprocessed/*")
  unprocessed_posts.each do |unprocessed_post|
    process_post(unprocessed_post)
    mv unprocessed_post, "db/posts/processed"
  end

  puts "#{unprocessed_posts.count} posts processed and moved to the processed folder."
end

def process_post(filename)
  parser = ReconDatabase::BrestParser.new(filename)
  parser.solves.each { |solve| solve.save }
  puts parser.name
end

task :reprocess do
  database_file = "db/db.sqlite"
  rm database_file if File.exist? database_file
  migrate

  Sequel::Model.db = Sequel.sqlite database_file
  ReconDatabase::Solve.db = Sequel::Model.db


  processed_posts = Dir.glob("db/posts/processed/*")
  processed_posts.each do |post|
    mv post, "db/posts/unprocessed"
  end

  process_all_posts
end
