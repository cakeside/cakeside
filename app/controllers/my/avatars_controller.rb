module My
  class AvatarsController < BaseController
    def new
      @avatar = current_user.avatar || Photo.new
    end

    def create
      UploadAvatar.new.run(current_user, params)
      redirect_to new_my_avatar_path, notice: t(:avatar_uploaded)
    end
  end
end
