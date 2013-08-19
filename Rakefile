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

task :sequel do
  system "sequel 'sqlite://db/db.sqlite'"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['spec/*_spec.rb']
end
task :migrate do
  Sequel.extension :migration
  db = Sequel.sqlite "db/db.sqlite"
  Sequel::Migrator.apply db, "db/migrations"
end

def process_post(post, average)
  average = ReconDatabase::Average.new
  average.save
  ReconDatabase::BrestParser.new(File.read(post), average).solves.each do |solve|
    solve = ReconDatabase::Solve.new(solve)
    solve.date_added = Time.now.to_i
    average.add_solve(solve)
  end
  mv post, "db/posts/processed"
end

task :import do
  Dir.glob("db/posts/unprocessed/*").each_with_index do |post, average|
    puts "Processing #{post}"
    process_post(post, average)
  end
end

task :newsolve do
  puts <<EOF
solves:
  - :solver:
    :time:
    :scramble:
    :solution:
    :competition: Unofficial
    :puzzle:
    :penalty:
    :youtube:
    :source:
    :reconstructor:
EOF
end

task :yamlimport do
  files = Dir.glob("db/manual_solves/unprocessed/*.yml")
  files.each do |file|
    average = ReconDatabase::Average.new
    average.save
    solves = YAML.load(File.read(file))["solves"]
    solves.each do |solve|
      solve = ReconDatabase::Solve.new(solve)
      solve.date_added = Time.now.to_i
      average.add_solve(solve)
    end
    mkdir "db/manual_solves/processed" unless Dir.exist? "db/manual_solves/processed"
    mv file, "db/manual_solves/processed"
  end
end
