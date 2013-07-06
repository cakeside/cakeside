class AddCreationsCountToUsers < ActiveRecord::Migration
  def up
    add_column :users, :creations_count, :integer, :default => 0
    User.reset_column_information
    User.find_each do |user|
      User.reset_counters user.id, :creations
    end
  end

  def down
    remove_column :users, :creations_count
  end
end
