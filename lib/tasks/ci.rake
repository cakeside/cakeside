task :ci => ['db:migrate', 'db:test:prepare', 'spec', 'teaspoon']
