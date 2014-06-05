class BlobStorage
  attr_reader :bucket_name

  def initialize(bucket_name = ENV['FOG_DIRECTORY'])
    @bucket_name = bucket_name
  end

  def upload(key, file)
    puts "uploading to #{bucket_name}/#{key}"
    object = connection.buckets[bucket_name].objects[key]
    object.write(Pathname.new(file), content_type: content_type_for(file), cache_control: 'public, max-age=315576000')
  end

  private

  def connection
    @connection ||= AWS::S3.new
  end

  def content_type_for(file)
    ::MIME::Types.type_for(file).first.to_s
  end
end
