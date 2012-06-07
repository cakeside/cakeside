# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Cake::Application.load_tasks

task :install_keys do
  sh "cp doc/keys/*.pem ~/.ssh/amazon-cakeside/"
end

namespace :deploy do
  task :staging => :spec do
    sh "cap staging deploy"
    sh "cap staging deploy:migrations"
    sh "curl http://staging.cakeside.com/ > /dev/null"
  end
  task :production, :tag do |t, args|
    tag_to_deploy = args.tag
    if tag_to_deploy.blank?
      puts "please specify the name of the tag to deploy"
      puts "E.g. rake deploy:production['staging-2012-06-02-1-mo-user-settings']"
    else
      puts "deploying to production from tag #{tag_to_deploy}"
      sh "cap production deploy -s tag=#{tag_to_deploy}"
      sh "cap production deploy:migrations"
      sh "curl http://cakeside.com/ > /dev/null"
    end
  end
end

