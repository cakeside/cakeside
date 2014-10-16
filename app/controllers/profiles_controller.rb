class ProfilesController < ApplicationController
  before_action :authenticate!, :except => [:index, :show]

  def initialize(repository = Spank::IOC.resolve(:users))
    @repository = repository
    super()
  end

  def index
    @profiles = repository.artists.page(params[:page]).per(12)
  end

  def show
    @user = repository.find(params[:id])
    @creations = @user.creations.includes(:photos)
  end

  private

  attr_reader :repository
end
