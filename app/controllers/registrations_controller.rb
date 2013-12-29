class RegistrationsController < Devise::RegistrationsController
  def edit
    @user = current_user
  end

  # is this action used any more?
  #def update
    #@user = current_user
    #@user.interest_ids = params[:user][:interest_ids] ||= []
    #if @user.update_without_password(params[:user])
      #sign_in @user, :bypass => true
      #redirect_to profile_path(current_user), :notice =>'Your settings have been updated successfully!'
    #else
      #render "edit"
    #end
  #end

  def after_sign_in_path_for(resource)
    settings_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :city, :email, :password, :password_confirmation)
  end
end
