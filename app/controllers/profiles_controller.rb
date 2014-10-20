class ProfilesController < ApplicationController
  def initialize(repository = Spank::IOC.resolve(:users))
    @repository = repository
    super()
  end

  def index
    @profiles = repository.search_with(params.merge(artists: true)).page(page).per(per_page)
  end

  def show
    @user = repository.find(params[:id])
    @creations = @user.creations.includes(:photos)
  end

  private

  attr_reader :repository
end
