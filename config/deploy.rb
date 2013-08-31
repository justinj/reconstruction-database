# config/deploy.rb
require "rvm/capistrano"
require "capistrano-unicorn"

set :application, "rcdb"
set :repository,  "git@github.com:justinj/reconstruction-database.git"
set :rvm_type, :system

set :scm, :git

role :web, "rcdb"
role :app, "rcdb"

set :app_env, "production"

task :prod do
  set :deploy_to, "/home/rcdb"
end

set :unicorn_pid, "/home/unicorn/pids/unicorn.pid"
after 'deploy:restart', 'unicorn:restart'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd /home/rcdb/current && bundle install"
    run "cp /home/rcdb/.env /home/rcdb/current"
    run "cd /home/rcdb/current && rake migrate"
  end
end
