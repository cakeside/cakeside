class CreationTagsController < ApplicationController
  def index
    @tags = Creation.tag_counts_on(:tags)
  end

  def show
    @tag = params[:id].downcase.gsub(/ /, '-')
    @total_tutorials = Tutorial.tagged_with(@tag).count
    @total_creations = Creation.tagged_with(@tag).count
    @creations = Creation.includes([:user, :tags, :photos]).tagged_with([@tag]).where('photos_count > 0').page(params[:page]).per(15)
  end
end
