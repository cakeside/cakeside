class Avatar < ActiveRecord::Base
  belongs_to :user
  #mount_uploader :avatar, AvatarUploader

  def attach(file)
    self.avatar=file
    self.save
  end
end
