class TagsController < ApplicationController
  def show
    @tag = params[:id]
    @tutorials = Tutorial.tagged_with([@tag])
    @creations = Creation.includes(:user).tagged_with([@tag])
  end
end
