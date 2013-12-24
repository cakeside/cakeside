class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation, :counter_cache => true
end
