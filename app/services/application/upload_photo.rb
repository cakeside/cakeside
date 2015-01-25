class UploadPhoto
  attr_reader :cake, :storage

  def initialize(cake)
    @cake = cake
    @storage = TemporaryStorage.new
  end

  def run(params)
    with_transaction do
      create_photo!(params[:watermark]) do |photo|
        ProcessPhotoJob.perform_later(photo, storage.store(params[:image]))
      end
    end
  end

  private

  def with_transaction
    ActiveRecord::Base.transaction do
      yield
    end
  end

  def create_photo!(watermark)
    cake.photos.create!(image_processing: true, watermark: watermark).tap do |photo|
      yield photo
    end
  end
end
