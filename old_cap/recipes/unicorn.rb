namespace :unicorn do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command, roles: :app do
      run "service unicorn_#{application} #{command}"
    end
    after "deploy:#{command}", "unicorn:#{command}"
  end

  desc "tail the logs on an app server (cap staging unicorn:logs)"
  task :logs, roles: :app do
    stream "tail -f #{shared_path}/log/unicorn.log"
  end
end
