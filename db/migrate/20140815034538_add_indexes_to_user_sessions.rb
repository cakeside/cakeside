class AddIndexesToUserSessions < ActiveRecord::Migration
  def change
    add_index :user_sessions, :user_id
    add_index :user_sessions, :key
    add_index :user_sessions, :accessed_at
    add_index :user_sessions, :revoked_at
  end
end
