class RegistrationsController < Devise::RegistrationsController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
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

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
