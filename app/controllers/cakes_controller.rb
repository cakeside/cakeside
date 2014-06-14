class CakesController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@cakes = Creation.all.limit(10))
  end
end
