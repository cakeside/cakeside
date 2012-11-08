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
