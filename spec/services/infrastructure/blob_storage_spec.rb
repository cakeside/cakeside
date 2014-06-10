require "spec_helper"

describe BlobStorage do
  let(:bucket) { ENV['FOG_DIRECTORY'] }
  subject { BlobStorage.new }

  context "when uploading" do
    let(:file) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }

    it "uploads to s3" do
      key = "test#{SecureRandom.uuid}"
      subject.upload(key, file)

      object = AWS::S3.new.buckets[bucket].objects[key]
      expect(object.exists?).to be_truthy
    end
  end
end
