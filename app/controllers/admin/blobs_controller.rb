module Admin
  class BlobsController < AdminController
    def index
      @objects = bucket.objects
    end

    def show
      @object = bucket.objects[params[:id]]
    end

    private

    def connection
      @connection ||= Aws::S3::Client.new
    end

    def bucket
      bucket_name = ENV['FOG_DIRECTORY']
      connection.buckets[bucket_name]
    end
  end
end
