class CreationsController < ApplicationController
  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
    expires_in(10.minutes) unless user_signed_in?
  end

  def show
    @creation = FindCreationQuery.new.fetch(params[:id])
    expires_in(1.minute) unless user_signed_in?
  end
end
