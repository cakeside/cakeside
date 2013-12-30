# encoding: utf-8
class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  include ::CarrierWave::Backgrounder::Delay

  process :set_content_type

  version :large do 
    process :resize_to_fit => [570, 630]
    process :watermark
  end

  version :thumb, :from_version => :large do
    process :resize_to_fill => [260, 180]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def watermark
    return if model.watermark.blank?
    manipulate! do |image|
      gc = Magick::Draw.new
      gc.gravity = Magick::SouthEastGravity
      gc.pointsize = 28
      gc.font_family = "Helvetica"
      gc.font_weight = Magick::BoldWeight
      gc.stroke = 'none'
      mark = Magick::Image.new(image.columns, image.rows)
      gc.annotate(mark, 0, 0, 25, 25, "#{model.watermark} on CakeSide.com")
      mark = mark.shade(true, 310, 30)
      image.composite!(mark, Magick::SouthEastGravity, Magick::HardLightCompositeOp)
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #def filename
    #if original_filename 
      #super.chomp(File.extname(super)) + '.png'
    #end
  #end
  def default_url
   "/assets/#{version_name}_default.png"
  end
end
