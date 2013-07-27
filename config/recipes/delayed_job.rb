namespace :delayed_job do 
  %w[start stop restart].each do |command|
    desc "#{command} delayed_job"
    task command, :roles => :app do
      #run "chmod +x #{current_path}/script/restart_delayed_job"
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job #{command}"
    end
    after "deploy:#{command}", "delayed_job:#{command}"
  end
end
