namespace :delayed_job do 
  desc "start the delayed_job process"
  task :start, :roles => :app do
    run "chmod +x #{current_path}/script/restart_delayed_job"
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
  end
  after "deploy:start", "delayed_job:start"

  desc "stop the delayed_job process"
  task :stop, :roles => :app do
    run "chmod +x #{current_path}/script/restart_delayed_job"
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end
  after "deploy:stop", "delayed_job:stop"

  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
    run "chmod +x #{current_path}/script/restart_delayed_job"
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart"
  end
  after "deploy:restart", "delayed_job:restart"
end
