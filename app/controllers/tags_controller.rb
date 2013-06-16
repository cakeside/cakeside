class TagsController < ApplicationController
  def show
    @tag = params[:id]
    @tutorials = Tutorial.includes(:tags).tagged_with([@tag])
    @creations = Creation.includes([:tags, :user]).tagged_with([@tag])
  end
end
