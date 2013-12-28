task :ci => ['db:migrate', 'db:test:prepare', 'spec', 'teaspoon']

namespace :ci do
  namespace :deploy do
    task :staging => ['deploy:staging']
    task :production => ['deploy:production']
  end
end

