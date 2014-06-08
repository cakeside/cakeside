class ThumbnailVersion < Version
  def initialize(photo)
    super(photo, :thumb, "thumb_")
  end

  def adjust(image)
    image.resize_to_fill(width: 260, height: 180)
  end
end
