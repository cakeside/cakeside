class RecreateVersions < ActiveRecord::Migration
  def up
    Photo.all.each do |photo|
      puts "recreating #{photo.id}"
      Delayed::Job.enqueue RecreatePhotoVersions.new(photo.id)
    end
  end

  def down
  end
end
