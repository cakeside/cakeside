class RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(resource)
    mine_creations_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :city, :email, :password, :password_confirmation)
  end
end
