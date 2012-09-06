class Tutorial < ActiveRecord::Base
  attr_accessible :description, :heading, :url
  belongs_to :user
end
