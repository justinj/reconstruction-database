require "rake/testtask"

require_relative "lib/brest_parser"
require_relative "lib/database"

task :default do
  sh "ruby app.rb"
end

DATABASE_FILE = "db/db.sqlite"

task :reprocess do
  rm DATABASE_FILE if File.exist? DATABASE_FILE
  processed_posts = Dir.glob("db/posts/processed/*")
  processed_posts.each do |post|
    mv post, "db/posts/unprocessed"
  end
  process_all_posts
end

task :process do
  process_all_posts
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
  parser = BrestParser.new(filename)
  parser.save_to(ReconDatabase::SolveDatabase)
  puts parser.name
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end
