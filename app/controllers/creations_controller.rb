class CreationsController < ApplicationController
  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
  end

  def show
    @creation = FindCreationQuery.new.fetch(params[:id])
  end
end
