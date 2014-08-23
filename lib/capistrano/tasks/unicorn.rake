namespace :unicorn do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command do
      on roles(:app) do
        run "service unicorn_#{fetch(:application)} #{command}"
      end
    end
    #after "deploy:#{command}", "unicorn:#{command}"
  end

  desc "tail the logs on an app server (cap staging unicorn:logs)"
  task :logs do
    on roles(:app) do
      stream "tail -f #{fetch(:shared_path)}/log/unicorn.log"
    end
  end
end
