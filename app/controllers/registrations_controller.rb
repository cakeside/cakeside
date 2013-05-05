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
    MixPanel.track "Signed In", {}, @request_env
    edit_user_registration_path
  end

  private

  def initialize_env
    @request_env = {
      'REMOTE_ADDR' => request.env['REMOTE_ADDR'],
      'HTTP_X_FORWARDED_FOR' => request.env['HTTP_X_FORWARDED_FOR'],
      'rack.session' => request.env['rack.session'].to_hash,
      'mixpanel_events' => request.env['mixpanel_events']
    }
  end
end
