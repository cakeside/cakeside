class RegistrationsController < Devise::RegistrationsController
  #force_ssl
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.interest_ids = params[:user][:interest_ids] ||= []
    if @user.update_without_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to profiles_mine_path, :notice =>'Your settings have been updated successfully!'
    else
      render "edit"
    end
  end
end
