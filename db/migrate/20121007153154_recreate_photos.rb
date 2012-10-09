class MigrateImagesToPhotos < ActiveRecord::Migration
  def up
    Photo.all.each do |photo|
      puts "recreating versions for #{photo.id}"
      photo.image.recreate_versions!
    end
  end

  def down
  end
end
