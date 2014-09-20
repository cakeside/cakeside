class MigrateOldPhotos < ActiveRecord::Migration
  def change
    Photo.find_each do |photo|
      photo.update_attribute(:imageable_type, 'Creation')
    end
  end
end
