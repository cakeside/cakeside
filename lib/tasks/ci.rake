task :ci => ['db:migrate', 'db:test:prepare', 'spec', 'teaspoon']

namespace :ci do
  namespace :deploy do
    task :staging do
      now = Time.now
      sh "git tag -a 'staging-#{now.strftime('%Y-%m-%d')}-#{now.to_i}-jenkins-continuous-deployment' -m 'just push it'"
      sh "git push --tags"
      Rake::Task['deploy:staging'].invoke
    end
    task :production => ['deploy:production']
  end
end

