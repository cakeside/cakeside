class HomeController < ApplicationController
  def index
    @creations = Creation.all.reverse.take(4)
  end
end
