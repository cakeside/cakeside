class CreationTagsController < ApplicationController
  def index
    @tags = Creation.tag_counts_on(:tags)
  end

  def show
    @tag = params[:id].downcase.parameterize
    @creations = Creation.includes([:user, :photos]).tagged_with([@tag]).where('photos_count > 0').page(params[:page]).per(12)
  end
end
