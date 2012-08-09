class AvatarsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_or_build_avatar

  def create
    @avatar.avatar = params[:avatar][:avatar]
    if @avatar.save
      redirect_to(profiles_mine_path, :notice => 'Your new avatar has been uploaded.') 
    else
      flash[:error] = "could not upload photo"
    end
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
