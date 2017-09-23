class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :creation
  has_many :activities, as: :subject, dependent: :destroy
  after_create :create_activity

  private

  def create_activity
    transaction do
      Activity.create(user: creation.author, subject: self)
      creation.author.notify_of_activity
    end
  end
end
