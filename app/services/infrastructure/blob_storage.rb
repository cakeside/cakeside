class BlobStorage
  attr_reader :bucket_name

  def initialize(bucket_name = ENV['FOG_DIRECTORY'])
    @bucket_name = bucket_name
  end

  def upload(key, file)
    Rails.logger.info "uploading to #{bucket_name}/#{key}"
    object = object_for(key)
    object.write(Pathname.new(file), options_for(file))
    object.acl = :public_read
  end

  def download(key)
    object = object_for(key)
    File.open("#{Dir.tmpdir}/#{File.basename(key)}", "wb") do |tempfile|
      object.read do |chunk|
        tempfile.write(chunk)
      end
      yield tempfile
    end
  end

  private

  def object_for(key)
    connection.buckets[bucket_name].objects[key]
  end

  def connection
    @connection ||= AWS::S3.new
  end

  def content_type_for(file)
    ::MIME::Types.type_for(file).first.to_s
  end

  def options_for(file)
    {
      content_type: content_type_for(file),
      cache_control: 'public, max-age=315576000',
    }
  end

  class Fake
    def upload(*args)
    end

    def downlaod(*args)
    end
  end
end
