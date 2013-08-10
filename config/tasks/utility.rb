desc "tail the logs on an app server (cap staging logs)"
task :logs, roles: :app do
  stream "tail -f #{shared_path}/log/#{rails_env}.log"
end
