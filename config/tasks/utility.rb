desc "tail the logs on an app server (cap qa logs)"
task :logs, roles: :app do
  stream "tail -f #{shared_path}/log/#{rails_env}.log"
end
