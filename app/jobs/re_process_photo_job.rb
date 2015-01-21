class ReProcessPhotoJob < ActiveJob::Base
  queue_as :default

  def perform(photo)
    key = OriginalVersion.new(photo).create_key
    blob_storage.download(key) do |file|
      temp_file = file_storage.store(file)
      ProcessPhotoJob.perform_later(photo, temp_file)
    end
  end

  def file_storage
    TemporaryStorage.new
  end

  def blob_storage
    Spank::IOC.resolve(:blob_storage)
  end
end
