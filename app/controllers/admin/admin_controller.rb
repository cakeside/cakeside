module Admin
  class AdminController < ApplicationController
    before_filter :restrict_access!

    private

    def restrict_access!
      redirect_to root_path unless current_user.is_admin?
    end
  end
end
