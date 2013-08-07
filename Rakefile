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

task :jsonify do
  unprocessed_posts = Dir.glob("db/posts/unprocessed/*")
  mkdir "db/json" unless Dir.exist? "db/json"
  unprocessed_posts.each_with_index { |post, average| jsonify_post(post, average) }
end

def jsonify_post(post, average)
  ReconDatabase::BrestParser.new(post, average).solves.each do |solve|
    hash = solve.to_hash
    hash[:date_added] = Time.now.to_i
    json = JSON.pretty_generate(solve.to_hash)
    index = 0
    while File.exist?("db/json/#{solve.filename}_#{index}")
      index += 1
    end
    File.write("db/json/#{solve.filename}_#{index}", json)
  end
  mv post, "db/posts/processed"
end

task :reimport => :jsonify do
  database_file = "db/db.sqlite"
  rm database_file if File.exist? database_file
  migrate

  Sequel::Model.db = Sequel.sqlite database_file
  ReconDatabase::Solve.db = Sequel::Model.db

  jsons = Dir.glob("db/json/*")
  jsons.each do |post|
    ReconDatabase::Solve.from_json(File.read(post)).save
  end
end
