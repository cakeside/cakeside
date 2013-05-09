class AvatarsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_or_build_avatar

  def create
    @avatar.attach(params[:avatar][:avatar])
    redirect_to(profile_path(current_user), :notice => 'Your new avatar has been uploaded.') 
  end

  protected 

  def find_or_build_avatar
    if current_user.avatar == nil
      @avatar = current_user.avatar = Avatar.new
      current_user.save
    else
      @avatar = current_user.avatar
    end
  end
end
