module My
  class AvatarsController < BaseController
    def new
      @avatar = current_user.avatar || Photo.new
    end

    def create
      image = params[:photo][:image]
      ProcessAvatarJob.perform_later(current_user, storage.store(image))
      redirect_to new_my_avatar_path, notice: t(:avatar_uploaded)
    end

    private

    def storage
      TemporaryStorage.new
    end
  end
end
