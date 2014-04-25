set_default(:unicorn_user) { user }
set_default(:unicorn_pid) { "#{shared_path}/pids/unicorn.pid" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_log) { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc "setup unicorn"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/sockets"
    template "unicorn.rb.erb", unicorn_config
    template "unicorn_init.erb", "/tmp/unicorn_init"
    run "chmod +x /tmp/unicorn_init"
    run "#{sudo} mv /tmp/unicorn_init /etc/init.d/unicorn_#{application}"
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end
  after "deploy:setup", "unicorn:setup"

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
