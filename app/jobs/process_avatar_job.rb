class ProcessAvatarJob < ActiveJob::Base
  queue_as :default

  def perform(user, file_path)
    user.avatar = Photo.create!
    user.avatar.upload(file_path, blob_storage)
    user.avatar.save!
  end

  private

  def blob_storage
    @blob_storage ||= Spank::IOC.resolve(:blob_storage)
  end
end
