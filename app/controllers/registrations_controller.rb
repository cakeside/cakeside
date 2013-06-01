class RegistrationsController < Devise::RegistrationsController
  before_filter :initialize_env
  #force_ssl
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.interest_ids = params[:user][:interest_ids] ||= []
    if @user.update_without_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to profile_path(current_user), :notice =>'Your settings have been updated successfully!'
    else
      render "edit"
    end
  end

  def after_sign_in_path_for(resource)
    edit_user_registration_path
  end
end
