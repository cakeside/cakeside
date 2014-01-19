class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation, :counter_cache => true, touch: true
  after_create :create_activity

  def create_activity
    Activity.create(user: creation.author, subject: self)
  end
end
