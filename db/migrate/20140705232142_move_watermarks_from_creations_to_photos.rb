class MoveWatermarksFromCreationsToPhotos < ActiveRecord::Migration
  def change
    Photo.includes(:creation).find_each do |photo|
      say("migrating watermark: #{photo.creation.watermark} to #{photo.id}")
      photo.update_attribute(:watermark, photo.creation.watermark) if photo.creation.watermark.present?
    end
  end
end
