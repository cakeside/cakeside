class Photo < ActiveRecord::Base
  belongs_to :creation, :counter_cache => true, touch: true
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader
  process_in_background :image if Rails.env.test?
  store_in_background :image, UploadImageWorker unless Rails.env.test?

  def thumb_url
    image.thumb.url
  end

  def watermark
    creation.watermark
  end

  def is_processed?
    self.image_processing == nil
  end
end
