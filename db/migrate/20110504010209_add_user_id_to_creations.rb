class AddUserIdToCreations < ActiveRecord::Migration
  def self.up
    add_column :creations, :user_id, :int
  end

  def self.down
    remove_column :creations, :user_id
  end
end
