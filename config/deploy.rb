# config/deploy.rb
require "capistrano-rbenv"

set :application, "rcdb"
set :repository,  "git@github.com:justinj/reconstruction-database.git"

set :scm, :git

role :web, "www"
role :app, "www"

set :rbenv_ruby_version, "2.0.0-p247"

task :prod do
  set :deploy_to, "/home/www/rcdb"
end

task :stage do
  set :deploy_to, "/home/www/rcdb-stage"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd /home/www/rcdb/current && bundle install --deployment"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
