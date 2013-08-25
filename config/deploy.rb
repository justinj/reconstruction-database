# config/deploy.rb
require "rvm/capistrano"
require "capistrano-unicorn"

set :application, "rcdb"
set :repository,  "git@github.com:justinj/reconstruction-database.git"
set :rvm_type, :system

set :scm, :git

role :web, "int"
role :app, "int"

task :prod do
  set :deploy_to, "/home/www/rcdb"
end

task :stage do
  set :deploy_to, "/u/apps/rcdb"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd /home/rails/current && bundle install"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
