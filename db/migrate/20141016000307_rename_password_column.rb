class RenamePasswordColumn < ActiveRecord::Migration
  def change
    rename_column :users, :encrypted_password, :password_digest
    remove_column :users, :password_salt, :string
  end
end
