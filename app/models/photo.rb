class Photo < ActiveRecord::Base
  attr_accessible :is_primary, :creation, :image
  belongs_to :creation
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader

  after_save :enqueue
end
