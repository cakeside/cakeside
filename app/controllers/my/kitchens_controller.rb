module My
  class KitchensController < BaseController
    def show
      @tags = Tag.unique_tags
    end
  end
end
