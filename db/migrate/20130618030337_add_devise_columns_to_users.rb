class AddDeviseColumnsToUsers < ActiveRecord::Migration
  def change
    ## Encryptable
    add_column :users, :password_salt, :string

    ## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string

    ## Lockable
    add_column :users, :failed_attempts, :integer, :default => 0
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime

    # Token authenticatable
    add_column :users, :authentication_token, :string

    ## Invitable
    add_column :users, :invitation_token, :string

    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true
  end
end
