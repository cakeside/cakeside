# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Cake::Application.load_tasks

task :deploy_rc do
  sh "cap staging deploy"
end
task :deploy_live do
  sh "cap production deploy"
end
