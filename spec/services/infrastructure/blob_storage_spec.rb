require "spec_helper"

describe BlobStorage do
  context "when uploading" do
    let(:file) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }

    it "uploads to s3" do
      BlobStorage.new.upload("test#{SecureRandom.uuid}", file)
    end
  end
end
