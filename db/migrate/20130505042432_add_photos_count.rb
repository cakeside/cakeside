class AddPhotosCount < ActiveRecord::Migration
  def up
    add_column :creations, :photos_count, :integer, :default => 0

    Creation.reset_column_information
    Creation.find_each do |creation|
      Creation.reset_counters creation.id, :photos
    end
  end

  def down
    remove_column :creations, :photos_count
  end
end
