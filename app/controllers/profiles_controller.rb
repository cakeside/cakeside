class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @profiles = User.page(params[:page]).per(10)
  end

  def show
    @profile = User.find(params[:id])
  end

  def mine
    @creations = current_user.creations.page(params[:page]).per(16)
  end

end
