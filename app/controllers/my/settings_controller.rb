module My
  class SettingsController < BaseController
    def index
      @user = current_user
    end

    def update
      @user = current_user
      @user.interest_ids = params[:user][:interest_ids] ||= []
      if @user.update(user_params)
        redirect_to my_settings_path, notice: t(:profile_saved)
      else
        render :index
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :city, :website, :twitter, :facebook)
    end
  end
end
