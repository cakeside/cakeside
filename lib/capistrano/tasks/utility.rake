desc "tail the logs on an app server (cap staging logs)"
task :logs do
  on roles(:app) do
    #stream "tail -f #{fetch(:shared_path)}/log/#{fetch(:rails_env)}.log"
    execute "tail -F #{shared_path}/log/#{fetch(:rails_env)}.log"
  end
end

task :sync_logs do
  on roles(:app) do
    execute "s3cmd sync #{shared_path}/log/#{fetch(:rails_env)}.log-*.gz s3://cakeside-logs/#{fetch(:rails_env)}/rails/"
    execute "s3cmd sync #{shared_path}/log/delayed_job.log-*.gz s3://cakeside-logs/#{fetch(:rails_env)}/delayed_job/"
    execute "s3cmd sync #{shared_path}/log/unicorn.log-*.gz s3://cakeside-logs/#{fetch(:rails_env)}/unicorn/"
    #execute "chown deployer /var/log/nginx/cakeside.*.log-*.gz"
    #execute "s3cmd sync /var/log/nginx/cakeside.*.log-*.gz s3://cakeside-logs/#{fetch(:rails_env)}/nginx/"
  end
end
