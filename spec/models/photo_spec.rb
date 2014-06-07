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
      blob_storage.should have_received(:upload).with(upload_key("large_"), file)
      blob_storage.should have_received(:upload).with(upload_key("thumb_"), file)
    end

    it "sets the original filename" do
      subject.upload(file, blob_storage)
      subject.original_filename.should == "gps.jpg"
      subject.image.should == "gps.jpg"
    end

    it "specifies the content type" do
      subject.upload(file, blob_storage)
      subject.content_type.should == "image/jpeg"
    end

    it "applies the gps coordinates" do
      subject.upload(file, blob_storage)
      expect(subject.latitude).to eql(51.07296369444445)
      expect(subject.longitude).to eql(-114.101799)
    end

    def upload_key(prefix = '')
      "uploads/photo/image/#{subject.id}/#{prefix}gps.jpg"
    end
  end

  describe "#url_for" do
    let(:asset_host) { ENV['ASSET_HOST'] }

    before :each do
      subject.id = rand(100)
      subject.image = "blah.png"
    end

    it "returns the url to the large version" do
      expect(subject.url_for(:large)).to eql("#{asset_host}/uploads/photo/image/#{subject.id}/large_blah.png")
    end

    it "returns the url for the thumbnail version" do
      expect(subject.url_for(:thumb)).to eql("#{asset_host}/uploads/photo/image/#{subject.id}/thumb_blah.png")
    end

    it "returns the url for the original version" do
      expect(subject.url_for(:original)).to eql("#{asset_host}/uploads/photo/image/#{subject.id}/blah.png")
    end
  end
end
