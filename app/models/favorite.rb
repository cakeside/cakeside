class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation
  attr_accessible :user_id, :creation_id
end
