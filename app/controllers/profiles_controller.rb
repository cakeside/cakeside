class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @profiles = User.includes(:avatar).where('creations_count > 0').order(:creations_count => :desc).page(params[:page]).per(12)
    expires_in(1.hour)
  end

  def show
    @user = User.find(params[:id])
    @creations = @user.creations.includes([:user, :photos]).page(params[:page]).per(18)
    @nearby_users = @user.nearbys(50) || []
    expires_in(1.hour)
  end

  def favorites
    @user = current_user
    @favorites = current_user.favorites.includes(:creation)
    @creations = @favorites.map {|f| f.creation }
  end
end
