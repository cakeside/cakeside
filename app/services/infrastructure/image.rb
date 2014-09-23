class Image
  attr_reader :path

  def initialize(path, exif = ExifParser.new)
    @path = path
    @exif = exif
    ensure_in_whitelist!(@path)
  end

  def filename
    @filename ||= sanitize(@path)
  end

  def content_type
    @content_type ||= ::MIME::Types.type_for(filename).first.to_s
  end

  def geolocation
    @exif.parse_geolocation_from(@path)
  end

  def sha256
    @sha256 ||= Digest::SHA256.file(@path).to_s
  end

  def resize_to_fit(width:, height:)
    manipulate! do |image|
      image.resize "#{width}x#{height}"
      image = yield(image) if block_given?
      image
    end
  end

  def resize_to_fill(width:, height:, gravity: 'Center')
    manipulate! do |image|
      columns, rows = image[:dimensions]
      image.combine_options do |cmd|
        if width != columns || height != rows
          scale_x = width/columns.to_f
          scale_y = height/rows.to_f
          if scale_x >= scale_y
            columns = (scale_x * (columns + 0.5)).round
            rows = (scale_x * (rows + 0.5)).round
            cmd.resize "#{columns}"
          else
            columns = (scale_y * (columns + 0.5)).round
            rows = (scale_y * (rows + 0.5)).round
            cmd.resize "x#{rows}"
          end
        end
        cmd.gravity gravity
        cmd.background "rgba(255,255,255,0.0)"
        cmd.extent "#{width}x#{height}" if columns != width || rows != height
      end
      image = yield(image) if block_given?
      image
    end
  end

  def watermark(message)
    manipulate! do |image|
      image.combine_options do |c|
        c.gravity 'Southeast'
        c.draw "text 10,10 \"#{message} on CakeSide.com\""
        c.font 'helvetica'
        c.fill("#FFFFFF")
        c.pointsize 28
      end
      image
    end
  end

  private

  def manipulate!
    image = ::MiniMagick::Image.open(path)
    image = yield(image)
    image.write(path)
    image.run_command("identify", path)
  ensure
    image.try(:destroy!)
  end

  def sanitize(name)
    name = name.gsub("\\", "/")
    name = File.basename(name)
    name = name.gsub(sanitize_regexp,"_")
    name = "_#{name}" if name =~ /\A\.+\z/
    name = "unnamed" if name.size == 0
    return name.mb_chars.to_s
  end

  def sanitize_regexp
    /[^a-zA-Z0-9\.\-\+_]/
  end

  def ensure_in_whitelist!(path)
    unless %w(.jpg .jpeg .gif .png .bmp .tif).include?(File.extname(path).downcase)
      raise StandardError.new("This file is not in the whitelist. #{path}")
    end
  end
end
