class UploadAvatar
  def initialize(message_bus = Spank::IOC.resolve(:message_bus))
    @message_bus = message_bus
  end

  def run(user, params)
    @message_bus.publish(:upload_avatar, create_message_from(user, params))
  end

  private

  def create_message_from(user, payload)
    image = payload[:avatar][:avatar]
    {
      user_id: user.id,
      file_path: move_to_temporary_storage(image),
      original_filename: image.original_filename,
      content_type: image.content_type,
    }
  end

  def move_to_temporary_storage(image)
    "#{create_tmp_dir}/#{image.original_filename}".tap do |new_path|
      FileUtils.mv(image.path, new_path)
    end
  end

  def create_tmp_dir
    Rails.root.join("tmp/uploads/#{SecureRandom.uuid}").tap do |directory|
      system "mkdir -p #{directory}"
    end
  end
end
