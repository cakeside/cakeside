class CreationTagsController < ApplicationController
  def index
    @tags = Creation.tag_counts_on(:tags)
  end

  def show
    @tag = params[:id].downcase.parameterize
    @creations = Creation.tagged(@tag).page(params[:page]).per(12)
  end
end
