class FavoritesController < ApplicationController
  before_action :authenticate!

  def initialize(command_bus = Spank::IOC.resolve(:command_bus))
    @bus = command_bus
    super()
  end

  def index
    @creation = Creation.find(params[:creation_id])
    @favorites = @creation.favorites
  end

  def create
    cake = Creation.find(params[:creation_id])
    bus.publish(:add_cake_to_favorites, { user_id: current_user.id, cake_id: cake.id })
    redirect_to cake, notice: "This has been added to your favorites"
  end

  private

  attr_reader :bus
end
