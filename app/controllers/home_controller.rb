class HomeController < ApplicationController
  def index
    @creations = Creation.all.reverse.take(16)
  end
end
