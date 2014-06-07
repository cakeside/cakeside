class Image
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def filename
    @filename ||= sanitize(@path)
  end

  def resize_to_fit(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}"
      img = yield(img) if block_given?
      img
    end
  end

  def resize_to_fill(width, height, gravity = 'Center')
    manipulate! do |img|
      cols, rows = img[:dimensions]
      img.combine_options do |cmd|
        if width != cols || height != rows
          scale_x = width/cols.to_f
          scale_y = height/rows.to_f
          if scale_x >= scale_y
            cols = (scale_x * (cols + 0.5)).round
            rows = (scale_x * (rows + 0.5)).round
            cmd.resize "#{cols}"
          else
            cols = (scale_y * (cols + 0.5)).round
            rows = (scale_y * (rows + 0.5)).round
            cmd.resize "x#{rows}"
          end
        end
        cmd.gravity gravity
        cmd.background "rgba(255,255,255,0.0)"
        cmd.extent "#{width}x#{height}" if cols != width || rows != height
      end
      img = yield(img) if block_given?
      img
    end
  end

  private

  def manipulate!
    image = ::MiniMagick::Image.open(path)
    begin
      image = yield(image)
      image.write(path)
      image.run_command("identify", path)
    ensure
      image.destroy!
    end
  rescue ::MiniMagick::Error, ::MiniMagick::Invalid => e
    default = I18n.translate(:"errors.messages.mini_magick_processing_error", :e => e, :locale => :en)
    message = I18n.translate(:"errors.messages.mini_magick_processing_error", :e => e, :default => default)
    raise CarrierWave::ProcessingError, message
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
end
