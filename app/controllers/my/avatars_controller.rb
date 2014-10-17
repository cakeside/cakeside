module My
  class AvatarsController < BaseController
    def initialize(bus = Spank::IOC.resolve(:command_bus))
      @bus = bus
    end

    def new
      @avatar = current_user.avatar || Photo.new
    end

    def create
      publish(params[:photo][:image])
      redirect_to new_my_avatar_path, notice: t(:avatar_uploaded)
    end

    private

    def publish(image)
      @bus.publish(:upload_avatar, create_message_from(image))
    end

    def create_message_from(image)
      {
        user_id: current_user.id,
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
end
