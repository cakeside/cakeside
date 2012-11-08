class RemoveIsPrimaryFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :is_primary
  end

  def down
  end
end
