class Photo < ActiveRecord::Base
  attr_accessible :is_primary, :creation, :image
  belongs_to :creation
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader
  process_in_background :image

  def watermark
    creation.watermark
  end

  def to_s
    "#{id} #{image}"
  end
end
