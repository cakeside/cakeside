module Admin
  class AdminController < ApplicationController
    layout "admin"
    before_filter :restrict_access!

    private

    def restrict_access!
      redirect_to root_path unless current_user.try(:is_admin?)
    end
  end
end
