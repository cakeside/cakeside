namespace :rails do
  desc "Remote console"
  task :console do
    on roles(:app) do
      run_interactively "bundle exec rails console #{fetch(:rails_env)}"
    end
  end

  desc "Remote dbconsole"
  task :dbconsole do
    on roles(:app) do
      run_interactively "bundle exec rails dbconsole #{fetch(:rails_env)}"
    end
  end

  def run_interactively(command, server=nil)
    server ||= find_servers_for_task(current_task).first
    exec %Q(ssh #{user}@#{server.host} -t 'cd #{current_path} && #{command}')
  end
end
