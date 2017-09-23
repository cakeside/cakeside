class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true # favorite, comment
  belongs_to :user # user to notify
end
