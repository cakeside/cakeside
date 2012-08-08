class AvatarsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @avatar = current_user.avatar.build(params[:avatar])

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to(current_user, :notice => 'Your new avatar has been uploaded.') }
      else
        flash[:error] = "could not upload photo"
      end
    end
  end
end
