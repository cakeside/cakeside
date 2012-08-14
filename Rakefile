# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Cake::Application.load_tasks

desc "install ssh keys"
task :install_keys do
  sh "cp doc/keys/*.pem ~/.ssh/amazon-cakeside/"
end

namespace :ssh do
  desc "deploy to staging server"
  task :staging do
    sh "ssh ubuntu@ec2-23-22-119-121.compute-1.amazonaws.com -i ~/.ssh/amazon-cakeside/stagingcakesidecom.pem"
  end
end

namespace :deploy do
  desc "deploy to staging server"
  task :staging => :spec do
    #sh "cap staging deploy"
    sh "cap staging deploy:migrations"
    sh "curl http://staging.cakeside.com/ > /dev/null"
  end
  desc "deploy to production server"
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

task :restore do
  # 1. backup prod database
  #sh "cap production backup_db"
  # 2. copy backup to staging
  sh "ls -1tr db/backups/ | tail -n 1"
  # 3. restore backup on staging
  #sh "cap staging restore_db"
end

