  class Version
    attr_reader :key, :prefix, :photo

    def initialize(photo, key, prefix)
      @key = key
      @prefix = prefix
      @photo = photo
    end

    def adjust(image)
      fail "Please override with version specific behaviours"
    end

    def for?(other_key)
      key == other_key
    end

    def url_for(asset_host)
      if photo.is_processed?
        "#{asset_host}/#{create_key}"
      else
        ActionController::Base.helpers.asset_path("#{key}_default.png")
      end
    end

    def create_key
      "uploads/photo/image/#{photo.id}/#{prefix}#{photo.image}"
    end
  end
