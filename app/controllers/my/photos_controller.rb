module My
  class PhotosController < BaseController
    before_filter :find_creation

    def initialize(mapper = PhotoToJQJsonMapper.new)
      @mapper = mapper
      super()
    end

    def index
      @photos = @cake.photos
      render json: { files: @photos.map { |photo| @mapper.map_from(photo) } }
    end

    def new
      @photo = Photo.new
    end

    def create
      attributes = photo_params
      if params[:photo][:image].class == Array
        attributes[:image] = params[:photo][:image].first
      end

      @photo = @cake.photos.build(attributes)
      if @photo.save
        render :json => {files: [@mapper.map_from(@photo)]}.to_json
      else
        render :json => [{:error => "oops... we're sorry but we weren't able to upload your photo."}], :status => 304
      end
    end

    def destroy
      @photo = @cake.photos.find(params[:id])
      if @photo.destroy
        @cake.touch
        render :json => {files: [@mapper.map_from(@photo)]}.to_json
      else
        render :json => [{:error => "could not remove the photo"}], :status => 304
      end
    end

    private

    def find_creation
      @cake = current_user.creations.find(params[:cake_id])
      raise ActiveRecord::RecordNotFound unless @cake
    end

    def photo_params
      params.require(:photo).permit(:image)
    end
  end
end

class PhotoToJQJsonMapper
  def map_from(photo)
    {
      :name => photo.read_attribute(:image),
      :url => photo.image.url,
      :thumbnail_url => photo.is_processed? ? photo.image.thumb.url : photo.image.thumb.default_url,
      :delete_url => photo.id,
      :delete_type => "DELETE"
    }
  end
end
