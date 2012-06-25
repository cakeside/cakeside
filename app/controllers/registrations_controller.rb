class RegistrationsController < Devise::RegistrationsController
  #force_ssl
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.interest_ids = params[:user][:interest_ids] ||= []
    if params[:user][:password].blank? 
      if @user.update_without_password(params[:user])
        sign_in @user, :bypass => true
        flash[:notice]= 'Your settings have been updated successfully!'
        redirect_to profiles_mine_path
      else
        render "edit"
      end
    else
      if @user.update_with_password(params[:user])
        sign_in @user, :bypass => true
        flash[:notice]= 'Your settings have been updated successfully!'
        redirect_to profiles_mine_path
      else
        render "edit"
      end
    end
  end
end
