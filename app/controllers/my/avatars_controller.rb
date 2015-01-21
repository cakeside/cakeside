module My
  class AvatarsController < BaseController
    def new
      @avatar = current_user.avatar || Photo.new
    end

    def create
      image = params[:photo][:image]
      ProcessAvatarJob.perform_later(current_user, move_to_temporary_storage(image))
      redirect_to new_my_avatar_path, notice: t(:avatar_uploaded)
    end

    private

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
