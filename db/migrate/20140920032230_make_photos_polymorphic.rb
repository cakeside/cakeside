class MakePhotosPolymorphic < ActiveRecord::Migration
  def change
    rename_column :photos, :creation_id, :imageable_id
    add_column :photos, :imageable_type, :string
  end
end
