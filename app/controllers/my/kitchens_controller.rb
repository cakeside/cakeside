module My
  class KitchensController < BaseController
    def show
      @tags = Tag.unique_tags
      @cakes = current_user.creations.includes(:category, :photos, :tags, :tag_taggings)
    end
  end
end
