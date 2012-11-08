class RemoveIsPrimaryFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :is_primary
  end

  def down
    add_column :photos, :is_primary, :boolean, :default => false
  end
end
