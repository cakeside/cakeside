class ProfilesController < ApplicationController
  before_action :authenticate!, :except => [:index, :show]

  def index
    @profiles = User.includes(:avatar).where('creations_count > 0').order(:creations_count => :desc).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @creations = @user.creations.includes([:user, :photos])
  end
end
