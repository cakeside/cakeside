class Photo < ActiveRecord::Base
  belongs_to :creation, :counter_cache => true, touch: true
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader
  process_in_background :image if Rails.env.test?
  store_in_background :image unless Rails.env.test?

  def to_jq_upload
    {
      :name => read_attribute(:image),
      :url => image.url,
      :thumbnail_url => is_processed? ? image.thumb.url : image.thumb.default_url,
      :delete_url => id,
      :delete_type => "DELETE"
    }
  end

  def thumb_url
    image.thumb.url
  end

  def watermark
    creation.watermark
  end

  private

  def is_processed?
    self.image_processing == nil
  end
end
