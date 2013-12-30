class Avatar < ActiveRecord::Base
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  process_in_background :avatar

  def attach(file)
    self.avatar=file
    self.save
  end
end
