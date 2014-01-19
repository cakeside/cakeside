class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation
  has_many :activities, as: :subject
  after_create :create_activity

  private

  def create_activity
    Activity.create(user: user, subject: self)
  end
end
