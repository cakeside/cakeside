class CreationTagsController < ApplicationController
  def index
    @tags = Creation.tag_counts_on(:tags)
    expires_in(6.hours)
    fresh_when(@tags) if @tags.any?
  end

  def show
    @tag = params[:id].downcase.gsub(/ /, '-')
    @total_tutorials = Tutorial.tagged_with(@tag).count
    @total_creations = Creation.tagged_with(@tag).count
    @creations = Creation.includes([:user, :tags, :photos]).tagged_with([@tag]).where('photos_count > 0').page(params[:page]).per(15)
    expires_in(6.hours)
    fresh_when(@tag)
  end
end
