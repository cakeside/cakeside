class AvatarsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_or_build_avatar

  def edit
  end

  def update
    @avatar.attach(params[:avatar][:avatar])
    redirect_to edit_avatar_path(current_user), :notice => 'Your avatar has been updated.'
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
