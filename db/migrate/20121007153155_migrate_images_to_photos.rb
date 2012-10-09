class MigrateImagesToPhotos < ActiveRecord::Migration
  def up
    add_column :photos, :is_primary, :boolean, :default => false

    Photo.reset_column_information
    Creation.all.each_with_index do |creation, index|
      puts "#{index}. processing #{creation.name}"
      photo = creation.photos.build({:is_primary => true})
      photo.created_at = creation.created_at
      photo.updated_at = creation.updated_at
      photo.image = creation.image.file
      photo.save!
      puts "#{index}. migrated #{creation.image.url} to #{photo.attributes}"
    end
    #add_index  :photos, :is_primary
    #remove_column :creations, :image
  end

  def down
    Photo.where(:is_primary => true).each do |photo|
      photo.destroy
    end
    #remove_index  :photos, :is_primary
    remove_column :photos, :is_primary
  end
end
