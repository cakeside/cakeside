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
