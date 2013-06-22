class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :set_content_type
  process :resize_to_fit => [1160, 870]

  version :thumb do
    process :resize_to_fill => [260, 260]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  #def filename
    #if original_filename 
      #super.chomp(File.extname(super)) + '.png'
    #end
  #end
end
