desc "tail the logs on an app server (cap staging logs)"
task :logs, roles: :app do
  stream "tail -f #{shared_path}/log/#{rails_env}.log"
end

task :sync_logs, roles: :app do
  run "s3cmd sync #{shared_path}/log/#{rails_env}.log-*.gz s3://cakeside-logs/#{rails_env}/"
  run "s3cmd sync #{shared_path}/log/delayed_job.log-*.gz s3://cakeside-logs/#{rails_env}/"
  run "s3cmd sync #{shared_path}/log/unicorn.log-*.gz s3://cakeside-logs/#{rails_env}/"
end
