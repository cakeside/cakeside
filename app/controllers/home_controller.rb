class HomeController < ApplicationController
  def index
    @creations = Creation.where(:is_restricted => false)
  end
end
