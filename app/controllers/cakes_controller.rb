class CakesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @cakes = current_user.creations
  end
end
