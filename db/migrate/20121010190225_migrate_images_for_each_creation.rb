class MigrateImagesForEachCreation < ActiveRecord::Migration
  def up
    Creation.all.each_with_index do |creation, index|
      creation.delay.migrate_primary_image
    end
    #remove_column :creations, :image
  end

  def down
    Photo.where(:is_primary => true).each do |photo|
      photo.destroy
    end
  end
end
