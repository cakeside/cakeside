class Avatar < ActiveRecord::Base
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  after_save :enqueue
end
