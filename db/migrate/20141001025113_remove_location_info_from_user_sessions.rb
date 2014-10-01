class RemoveLocationInfoFromUserSessions < ActiveRecord::Migration
  def change
    remove_column :user_sessions, :latitude
    remove_column :user_sessions, :longitude
    remove_column :user_sessions, :city
    remove_column :user_sessions, :country

    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :latitude
    remove_column :users, :longitude
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
    remove_column :users, :invitation_token
  end
end
