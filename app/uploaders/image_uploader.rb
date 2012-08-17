# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  if Rails.env.production?
    storage :fog
  elsif Rails.env.staging?
    storage :fog
  elsif Rails.env.development?
    storage :file
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :set_content_type
  process :convert => 'png'

  # Create different versions of your uploaded files:
  version :large do 
    process :manualcrop
    process :resize_to_fill => [910, 630]
    process :watermark
  end

  version :thumb, :from_version => :large do
    process :resize_to_fill => [260, 180]
  end

  def watermark
    manipulate! do |image|
      gc = Magick::Draw.new
      gc.gravity = Magick::SouthEastGravity
      gc.pointsize = 32
      gc.font_family = "Helvetica"
      gc.font_weight = Magick::BoldWeight
      gc.stroke = 'none'
      mark = Magick::Image.new(image.columns, image.rows)
      gc.annotate(mark, 0, 0, 25, 25, "CakeSide.com")
      mark = mark.shade(true, 310, 30)
      image.composite!(mark, Magick::SouthEastGravity, Magick::HardLightCompositeOp)
    end
  end

  def manualcrop
    manipulate! do |img|
      img = img.crop(model.crop_x.to_i, model.crop_y.to_i, model.crop_w.to_i, model.crop_h.to_i)
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename 
      super.chomp(File.extname(super)) + '.png'
    end
  end
end
