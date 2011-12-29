# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :s3
  if Rails.env.production?
    storage :fog
  elsif Rails.env.development?
    storage :file
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  #
  # Process files as they are uploaded:

  process :set_content_type
  # process :resize_to_fit => [700, 540]
  process :resize_to_fit => [660, 470]
  process :convert => 'png'
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :large do 
  #   process :resize_to_fit => [660, 470]
  # end

  version :thumb do
    process :manualcrop
    process :resize_to_fill => [210, 150]
  end

  def manualcrop
    return unless model.cropping?
    manipulate! do |img|
      img = img.crop(model.crop_x.to_i, model.crop_y.to_i,model.crop_h.to_i,model.crop_w.to_i)
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end
  def filename
    super.chomp(File.extname(super)) + '.png'
  end

end
