  class OriginalVersion < Version
    def initialize(photo)
      super(photo, :original, "")
    end

    def adjust(image); end
  end
