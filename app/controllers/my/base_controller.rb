module My
  class BaseController < ApplicationController
    before_filter :restrict_access!

    private

    def restrict_access!
      redirect_to root_path unless signed_in?
    end
  end
end
