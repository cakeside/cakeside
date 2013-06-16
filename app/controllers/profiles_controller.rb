class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @profiles = User.includes(:avatar).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @creations = @user.creations.includes(:user).page(params[:page]).per(18)
  end

  def favorites
    @user = current_user
    @favorites = current_user.favorites
    @creations = @favorites.map {|f| f.creation }
  end
end
