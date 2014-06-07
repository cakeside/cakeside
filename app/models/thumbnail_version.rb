  class ThumbnailVersion < Version
    def initialize(photo)
      super(photo, :thumb, "thumb_")
    end

    def adjust(image)
      image.resize_to_fill(260, 180)
    end
  end
