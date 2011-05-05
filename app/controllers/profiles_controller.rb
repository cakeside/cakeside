class ProfilesController < ApplicationController
  def index
    @profiles = User.all
  end

  def show
    @profile = User.find(params[:id])
  end

end
