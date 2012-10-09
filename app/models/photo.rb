class Photo < ActiveRecord::Base
  attr_accessible :is_primary, :creation, :image
  belongs_to :creation
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader
  #attr_accessor :crop_x, :crop_y, :crop_h, :crop_w
  #after_update :reprocess_image, :if => :cropping?

  #after_save :enqueue

  #def reprocess_image
    #begin
      #self.image.recreate_versions!
    #rescue Exception => e
      #logger.error e.message
      #logger.error e.backtrace.inspect
    #end
  #end
  #def cropping?
    #!crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  #end

  def watermark
    puts "#{creation} #{creation.watermark}"
    creation.watermark
  end
  
  def to_s
    "#{id} #{image}"
  end
end
