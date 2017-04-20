desc "tail the logs on an app server (cap production logs)"
task :logs do
  on roles(:app) do
    execute "tail -F #{shared_path}/log/#{fetch(:rails_env)}.log"
  end
end

task :sync_logs do
  on roles(:app) do
    bucket = ENV.fetch('AWS_S3_BACKUPS_BUCKET')
    execute "s3cmd sync #{shared_path}/log/#{fetch(:rails_env)}.log-*.gz s3://#{bucket}/#{fetch(:rails_env)}/rails/"
    execute "s3cmd sync #{shared_path}/log/delayed_job.log-*.gz s3://#{bucket}/#{fetch(:rails_env)}/delayed_job/"
    execute "s3cmd sync #{shared_path}/log/unicorn.log-*.gz s3://#{bucket}/#{fetch(:rails_env)}/unicorn/"
    execute "s3cmd sync /var/log/nginx/cakeside.*.log-*.gz s3://#{bucket}/#{fetch(:rails_env)}/nginx/"
  end
end
