task :ci => ['db:migrate', 'db:test:prepare', 'spec:controllers', 'spec:helpers', 'spec:models', 'spec:routing', 'spec:services', 'teaspoon']

namespace :ci do
  namespace :deploy do
    task :staging => ['deploy:staging']
    task :production => ['deploy:production']
  end
end

