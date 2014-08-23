namespace :delayed_job do
  %w[start stop restart status].each do |command|
    desc "#{command} delayed_job"
    task command do
      on roles(:app) do
        execute :sudo, "service delayed_job_#{fetch(:application)} #{command}"
      end
    end
    #after "deploy:#{command}", "delayed_job:#{command}"
    #after "deploy:finish", "delayed_job:restart"
  end

  desc "tail the delayed jobs logs on an app server (cap staging delayed_job:logs)"
  task :logs do
    on roles(:app) do
      stream "tail -f #{fetch(:shared_path)}/log/delayed_job.log"
    end
  end
end
