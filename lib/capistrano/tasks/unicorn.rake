namespace :unicorn do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command do
      on roles(:app) do
        execute "service unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  desc "tail the logs on an app server (cap production unicorn:logs)"
  task :logs do
    on roles(:app) do
      execute "tail -F #{shared_path}/log/unicorn.log"
    end
  end
end
