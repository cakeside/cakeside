class MigratePrimaryImage < Struct.new(:creation_id)
  def perform
    creation = Creation.find(creation_id)
    photo = creation.photos.build({})
    photo.created_at = creation.created_at
    photo.updated_at = creation.updated_at
    photo.image = creation.image.file
    photo.save!
  end
end

class MigrateImagesForEachCreation < ActiveRecord::Migration
  def up
    Creation.all.each_with_index do |creation, index|
      Delayed::Job.enqueue MigratePrimaryImage.new(creation.id)
    end
  end

  def down
    Photo.where(:is_primary => true).each do |photo|
      photo.destroy
    end
  end
end
