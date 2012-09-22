task :restore do
  # 1. backup prod database
  sh "cap production backup_db"
  # 2. copy backup to staging
  sh "rm -f latest && ln -s db/backups/`ls -rt db/backups/ | tail -n1` latest"
  # 3. restore backup on staging
  sh "cap staging restore_db"
end
