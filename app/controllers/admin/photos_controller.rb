module Admin
  class PhotosController < AdminController
    def initialize(photo_repository = Photo, storage = Spank::IOC.resolve(:blob_storage))
      @photo_repository = photo_repository
      @storage = storage
      super()
    end

    def index
      @photos = @photo_repository.order(id: :desc)
    end

    def show
      @photo = @photo_repository.find(params[:id])
    end

    def update
      photo = @photo_repository.find(params[:id])
      key = OriginalVersion.new(photo).create_key
      @storage.download(key) do |file|
        temp_file = move_to_temporary_storage(file.path, File.basename(key))
        ProcessPhotoJob.perform_later(photo, temp_file)
      end

      redirect_to admin_photos_path
    end

    private

    def move_to_temporary_storage(temp_file_path, original_filename)
      "#{create_tmp_dir}/#{original_filename}".tap do |new_path|
        FileUtils.mv(temp_file_path, new_path)
      end
    end

    def create_tmp_dir
      Rails.root.join("tmp/uploads/#{SecureRandom.uuid}").tap do |directory|
        system "mkdir -p #{directory}"
      end
    end
  end
end
