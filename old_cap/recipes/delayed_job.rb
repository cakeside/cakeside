namespace :delayed_job do 
  %w[start stop restart status].each do |command|
    desc "#{command} delayed_job"
    task command, roles: :app do
      run "#{sudo} service delayed_job_#{application} #{command}"
    end
    after "deploy:#{command}", "delayed_job:#{command}"
  end

  desc "tail the delayed jobs logs on an app server (cap staging delayed_job:logs)"
  task :logs, roles: :app do
    stream "tail -f #{shared_path}/log/delayed_job.log"
  end
end
