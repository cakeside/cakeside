task :ci => ['db:test:prepare', 'spec', 'jasmine:ci']

namespace :ci do
  task :deploy_staging do
    now = Time.now
    sh "git tag -a 'staging-#{now.strftime('%Y-%m-%d')}-#{now.to_i}-jenkins-continuous-deployment' -m 'just push it'"
    Rake::Task['deploy:staging'].invoke
  end
end

