namespace :delayed_job do
  %w[start stop restart status].each do |command|
    desc "#{command} delayed_job"
    task command do
      on roles(:app) do
        execute :sudo, "service delayed_job_#{fetch(:application)} #{command}"
      end
    end
  end

  desc "tail the delayed jobs logs on an app server (cap production delayed_job:logs)"
  task :logs do
    on roles(:app) do
      stream "tail -F #{fetch(:shared_path)}/log/delayed_job.log"
    end
  end
end
