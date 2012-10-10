class AddIsPrimaryToPhotos < ActiveRecord::Migration
  def up
    add_column :photos, :is_primary, :boolean, :default => false
    add_index  :photos, :is_primary
  end

  def down
    remove_index  :photos, :is_primary
    remove_column :photos, :is_primary
  end
end
