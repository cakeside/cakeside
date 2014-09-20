class ProcessAvatar
  def initialize(blob_storage)
    @blob_storage = blob_storage
  end

  def handles?(event)
    :upload_avatar == event
  end

  def handle(message)
    user = User.find(message[:user_id])
    user.avatar = Photo.create!(image_processing: true)
    user.avatar.upload(message[:file_path], @blob_storage)
    user.avatar.save!
  end
end
