require "rake/testtask"

task :default do
  sh "ruby app.rb"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end
