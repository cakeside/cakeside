class ReProcessPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo)
    photo.version(:original).download(blob_storage) do |file|
      ProcessPhotoJob.perform_later(photo, file_storage.store(file))
    end
  end

  def file_storage
    TemporaryStorage.new
  end

  def blob_storage
    Spank::IOC.resolve(:blob_storage)
  end
end
