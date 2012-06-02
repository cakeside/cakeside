# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Cake::Application.load_tasks

task :deploy_live do
  sh "cap production deploy"
end

task :install_keys do
  sh "cp doc/keys/*.pem ~/.ssh/amazon-cakeside/"
end

namespace :deploy do
  task :staging do
    #branch_name = "staging-#{Time.now.strftime('%Y-%m-%d-%T')}"
    #sh "git branch #{branch_name}"
    #sh "git push origin #{branch_name}"
    puts "staging is fun! #{branch_name}"
    #sh "cap staging deploy branch=#{branch_name}"
  end
end

