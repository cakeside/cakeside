class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @profiles = User.all
  end

  def show
    @profile = User.find(params[:id])
  end

end
