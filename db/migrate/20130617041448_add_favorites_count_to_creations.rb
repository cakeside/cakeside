class AddFavoritesCountToCreations < ActiveRecord::Migration
  def up
    add_column :creations, :favorites_count, :integer, :default => 0
    Creation.reset_column_information
    Creation.find_each do |creation|
      Creation.reset_counters creation.id, :favorites
    end
  end

  def down
    remove_column :creations, :favorites_count
  end
end
