class Favorite < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  belongs_to :user
  belongs_to :creation, :counter_cache => true
  attr_accessible :user_id, :creation_id
end
