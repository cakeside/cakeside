module My
  class AvatarsController < BaseController
    before_action :find_or_build_avatar

    def edit
    end

    def update
      @avatar.attach(params[:avatar][:avatar])
      redirect_to edit_my_avatar_path(current_user), :notice => t(:avatar_uploaded)
    end

    protected 

    def find_or_build_avatar
      if current_user.avatar == nil
        @avatar = current_user.avatar = Avatar.new
        current_user.save
      else
        @avatar = current_user.avatar
      end
    end
  end
end
