class Photo < ActiveRecord::Base
  belongs_to :creation, counter_cache: true, touch: true
  mount_uploader :image, PhotoUploader

  def thumb_url
    image.thumb.url
  end

  def watermark
    return '' if creation.nil?
    creation.watermark
  end

  def is_processed?
    !self.image_processing
  end
end
