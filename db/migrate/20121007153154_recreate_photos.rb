class RecreatePhotos < ActiveRecord::Migration
  def up
    Photo.all.each do |photo|
      puts "recreating #{photo.id}"
      photo.image.recreate_versions!
    end
  end

  def down
  end
end
