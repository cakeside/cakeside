class ExifParser
  def parse_geolocation_from(file)
    exif = EXIFR::JPEG.new(file)
    return [exif.gps.latitude, exif.gps.longitude] if exif.gps.present?
    [nil, nil]
  rescue EXIFR::MalformedJPEG
    [nil, nil]
  end
end
