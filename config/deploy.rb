#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p194@cakeside'
set :rvm_type, :system
require 'bundler/capistrano'                 # loads RVM's capistrano plugin
set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'capistrano/gitflow'
set :application, "www.cakeside.com"
set :deploy_via, :remote_cache
set :user, "cakeside"
set :password, "password"
set :group, "rvm"
set :use_sudo, false
set :deploy_to, "/home/cakeside/apps/#{application}"

set :scm, :git
set :repository,  "git@bitbucket.org:mocheen/cakeside.git"
set :keep_releases, 3
set :branch, "master"
set :deploy_env, 'production'
set :scm_verbose, true
set :normalize_asset_timestamps, false

after "deploy:setup", "rvm:install_rvm"
before "deploy", "rvm:install_ruby"
after "deploy", "deploy:cleanup" # remove old releases
after 'deploy:update_code', 'deploy:symlink_db'
after "deploy:start", "delayed_job:start"
after "deploy:stop", "delayed_job:stop"
after "deploy:restart", "delayed_job:restart"
after "deploy:restart", "restart_server"

task :restart_server do
    run "cd #{current_path}; touch tmp/restart.txt"
end

namespace :deploy do
  task :symlink_db, :roles => :app do
    run "ln -nfs #{release_path}/config/database.production.yml.example #{release_path}/config/database.yml"
  end
end
namespace :delayed_job do 
  desc "start the delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
  end
  desc "stop the delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end
  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart"
  end
end
