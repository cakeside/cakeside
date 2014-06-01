class ExifParser
  def parse_geolocation_from(file)
    exif = EXIFR::JPEG.new(file)
    return [exif.gps.latitude, exif.gps.longitude] if exif.gps.present?
    [0, 0]
  rescue EXIFR::MalformedJPEG
    [0, 0]
  end
end
