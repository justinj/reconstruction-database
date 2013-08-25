# config/deploy.rb

set :application, "rcdb"
set :repository,  "git@github.com:justinj/reconstruction-database.git"

set :scm, :git

role :web, "int"
role :app, "int"

task :prod do
  set :deploy_to, "/home/www/rcdb"
end

task :stage do
  set :deploy_to, "/home/rails"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd /home/rails && bundle install --deployment"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
