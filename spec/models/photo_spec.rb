require "spec_helper"

describe Photo do
  subject { Photo.new }

  describe "#upload" do
    let(:file) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }
    let(:blob_storage) { double(upload: true) }

    it "uploads each version to the blob storage" do
      subject.id = rand(100)
      subject.upload(file, blob_storage)
      blob_storage.should have_received(:upload).with(upload_key, file)
      blob_storage.should have_received(:upload).with(upload_key("large"), file)
      blob_storage.should have_received(:upload).with(upload_key("thumb"), file)
    end

    def upload_key(prefix = '')
      "uploads/photo/image/#{subject.id}/#{prefix}_gps.jpg"
    end
  end
end
