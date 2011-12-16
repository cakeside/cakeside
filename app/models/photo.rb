class Photo < ActiveRecord::Base
  belongs_to :creation
  mount_uploader :image, PhotoUploader
end
