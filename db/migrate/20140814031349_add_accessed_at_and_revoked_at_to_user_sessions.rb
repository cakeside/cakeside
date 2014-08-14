class AddAccessedAtAndRevokedAtToUserSessions < ActiveRecord::Migration
  def change
    change_table :user_sessions do |t|
      t.column :key, :string
      t.column :ip, :string
      t.column :user_agent, :string
      t.column :accessed_at, :datetime
      t.column :revoked_at, :datetime, null: true
    end
  end
end
