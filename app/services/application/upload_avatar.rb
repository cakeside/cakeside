class UploadAvatar
  def initialize(command_bus = Spank::IOC.resolve(:command_bus))
    @command_bus = command_bus
  end

  def run(user, image)
    @command_bus.publish(:upload_avatar, create_message_from(user, image))
  end

  private

  def create_message_from(user, image)
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
