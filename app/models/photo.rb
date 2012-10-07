class Photo < ActiveRecord::Base
  belongs_to :creation
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader

  after_save :enqueue
end
