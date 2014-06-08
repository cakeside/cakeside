class LargeVersion < Version
  def initialize(photo)
    super(photo, :large, "large_")
  end

  def adjust(image)
    image.resize_to_fit(width: 570, height: 630)
  end
end
