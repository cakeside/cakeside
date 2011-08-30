set :application, "www.cakeside.com"
set :repository,  "git@cakeartist.unfuddle.com:cakeartist/cake.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to, "/home/cakeside/apps/#{application}"

role :web, "ec2-50-16-149-107.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-50-16-149-107.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-50-16-149-107.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run

set :user, "cakeside"
set :use_sudo, false
set :rvm_type, :system

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"                              
# require 'bundler/capistrano'
set :rvm_ruby_string, '1.9.2@cakeside'
set :rvm_type, :user

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "amazon-cakeside", "cakeside.pem")] 
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#
#
namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_release} & rvm use 1.9.2 & rake thinking_sphinx:create RAILS_ENV=production & rake thinking_sphinx:start RAILS_ENV=production"
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end
