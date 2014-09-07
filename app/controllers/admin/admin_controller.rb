module Admin
  class AdminController < ApplicationController
    layout "admin"
    before_action :restrict_access!

    private

    def restrict_access!
      redirect_to root_path unless current_user.try(:admin?)
    end
  end
end
