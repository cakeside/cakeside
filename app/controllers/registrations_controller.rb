class RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(resource)
    settings_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :city, :email, :password, :password_confirmation)
  end
end
