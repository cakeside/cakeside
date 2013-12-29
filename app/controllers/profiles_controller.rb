class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @profiles = User.includes(:avatar).where('creations_count > 0').order(:creations_count => :desc).page(params[:page]).per(12)
    expires_in(1.hour)
    fresh_when(User.maximum(:updated_at)) if User.any?
  end

  def show
    @user = User.find(params[:id])
    @creations = @user.creations.includes([:user, :photos]).page(params[:page]).per(18)
    @nearby_users = @user.nearbys(50) || []
    @map_url = "http://maps.google.com/maps/api/staticmap?size=450x300&sensor=false&markers=#{@user.latitude}%2C#{@user.longitude}"
    @nearby_users.each do |user|
      @map_url += "&markers=#{user.latitude}%2C#{user.longitude}"
    end
    expires_in(1.hour)
    fresh_when(@user)
  end

  def favorites
    @user = current_user
    @favorites = current_user.favorites.includes(:creation)
    @creations = @favorites.map {|f| f.creation }
  end
end
