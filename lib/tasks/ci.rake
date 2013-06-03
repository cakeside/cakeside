task :ci => ['db:test:prepare', 'spec', 'jasmine:ci']
