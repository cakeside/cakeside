class HomeController < ApplicationController
  def index
    @creations = Creation.all
  end
end
