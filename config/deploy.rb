# config/deploy.rb
require "capistrano-rbenv"

set :application, "rcdb"
set :repository,  "git@github.com:justinj/reconstruction-database.git"

set :scm, :git

task "production" do
  role :web, "www"
  role :app, "www"
end

task "staging" do
  role :web, "stage"
  role :app, "stage"
end

set :rbenv_ruby_version, "2.0.0-p247"

set :deploy_to, "/home/www/rcdb"
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
