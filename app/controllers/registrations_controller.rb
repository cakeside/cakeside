class RegistrationsController < Devise::RegistrationsController
  def edit
    @user = current_user
  end

  def after_sign_in_path_for(resource)
    settings_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :city, :email, :password, :password_confirmation)
  end
end
