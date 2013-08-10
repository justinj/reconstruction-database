require "rake/testtask"
require "json"
require "tempfile"
require "yaml"
require "pp"
require_relative "lib/recondb"
require_relative "lib/brest_parser"

task :default do
  sh "ruby app.rb"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['spec/*_spec.rb']
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

task :newsolve do
  average = ReconDatabase::Average.new

  while STDIN.readline.chomp == "Y"
    empty_hash = ReconDatabase::Solve.columns.each_with_object({}) do |column, hsh|
      hsh[column] = ""
    end

    empty_hash.delete :id
    empty_hash.delete :average_id

    new_solve = ""

    Tempfile.open("recon_database") do |f|
      f.write(empty_hash.to_yaml)
      f.flush
      system "vim #{f.path}"
      new_solve = File.read(f.path)
    end

    average.save
    average.add_solve(YAML.load(new_solve))
  end
end

task :yamlimport do
  files = Dir.glob("db/manual_solves/unprocessed/*.yml")
  files.each do |file|
    average = ReconDatabase::Average.new
    average.save
    solves = YAML.load(File.read(file))["solves"]
    solves.each do |solve|
      solve = ReconDatabase::Solve.new(solve)
      average.add_solve(solve)
    end
    mkdir "db/manual_solves/processed" unless Dir.exist? "db/manual_solves/processed"
    mv file, "db/manual_solves/processed"
  end
end
