class NotificationsController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes([:trackable, :owner]).all
  end
end
