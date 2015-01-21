class ReProcessPhotoJob < ActiveJob::Base
  queue_as :default

  def perform(photo)
    key = OriginalVersion.new(photo).create_key
    @storage.download(key) do |file|
      temp_file = move_to_temporary_storage(file.path, File.basename(key))
      ProcessPhotoJob.perform_later(photo, temp_file)
    end
  end
end
