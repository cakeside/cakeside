# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  if Rails.env.production?
    storage :fog
  elsif Rails.env.development?
    storage :file
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  process :set_content_type
  process :resize_to_fit => [660, 460]
  process :convert => 'png'
  # process :manualcrop

  # Create different versions of your uploaded files:
  version :large do 
    process :manualcrop
    process :resize_to_fit => [660, 460]
  end

  version :thumb do
    process :resize_to_fill => [210, 150]
  end

  def manualcrop
    return unless model.cropping?
    manipulate! do |img|
      img = img.crop(model.crop_x.to_i, model.crop_y.to_i, model.crop_w.to_i, model.crop_h.to_i)
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
    # @name = Digest::MD5.hexdigest(super.chomp(File.extname(super)))
    # "#{@name}.png"
    super.chomp(File.extname(super)) + '.png'
  end
  # def filename 
  #   if original_filename 
  #     @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
  #     "#{@name}.png"
  #   end
  # end
end
