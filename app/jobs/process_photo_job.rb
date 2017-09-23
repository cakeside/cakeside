class ProcessPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo, file_path)
    photo.upload(file_path, storage)
    photo.save!
  end

  def storage
    Spank::IOC.resolve(:blob_storage)
  end
end
