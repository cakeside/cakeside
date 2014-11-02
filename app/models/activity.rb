class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true # favorite, comment
  belongs_to :user # user to notify
end
