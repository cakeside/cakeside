class UploadPhoto
  def initialize(cakes = Creation)
    @cakes = cakes
  end

  def run(cake_id, params)
    ActiveRecord::Base.transaction do
      photo = @cakes.find(cake_id).photos.create!(image_processing: true, watermark: params[:watermark])
      tempfile = move_to_temporary_storage(params[:image].path, params[:image].original_filename)
      ProcessPhotoJob.perform_later(photo, tempfile)
      photo
    end
  end

  private

  def move_to_temporary_storage(temp_file_path, original_filename)
    new_path = "#{create_tmp_dir}/#{original_filename}"
    FileUtils.mv(temp_file_path, new_path)
    new_path
  end

  def create_tmp_dir
    directory = Rails.root.join("tmp/uploads/#{SecureRandom.uuid}")
    system "mkdir -p #{directory}"
    directory
  end
end
