require "rake/testtask"

require_relative "lib/brest_parser"
require_relative "lib/database"

task :default do
  sh "ruby app.rb"
end

task :import, [:post] do |t, args|
  filename = args[:post] 
  parser = BrestParser.new(filename)
  parser.save_to(ReconDatabase::SolveDatabase)
  puts parser.name
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end
