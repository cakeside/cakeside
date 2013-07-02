class Avatar < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  def attach(file)
    self.avatar=file
    self.save
  end
end
