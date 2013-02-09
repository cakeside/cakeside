class TagsController < ApplicationController
  # GET /tags/fondant
  def show
    @tag = params[:id]
    @tutorials = Tutorial.tagged_with([@tag])
    @creations = Creation.tagged_with([@tag])
  end
end
