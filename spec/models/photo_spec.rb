require "spec_helper"

describe Photo do
  subject { Photo.new }

  describe "#upload" do
    let(:file) { "#{Tempfile.new('gps').path}.jpg" }
    let(:blob_storage) { double(upload: true) }

    before { FileUtils.cp(File.join(Rails.root, 'spec/fixtures/images/gps.jpg'), file) }
    after { FileUtils.rm(file) }

    it "uploads each version to the blob storage" do
      subject.id = rand(100)
      subject.upload(file, blob_storage)
      blob_storage.should have_received(:upload).with(upload_key, file)
      blob_storage.should have_received(:upload).with(upload_key("large_"), file)
      blob_storage.should have_received(:upload).with(upload_key("thumb_"), file)
    end

    it "sets the original filename" do
      subject.upload(file, blob_storage)
      subject.original_filename.should == File.basename(file)
      subject.image.should == File.basename(file)
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

    it "applies the sha256 of the file" do
      subject.upload(file, blob_storage)
      expect(subject.sha256).to eql("530990323da10ba4b8ab6a9809e9d694bd354831fd58afc96e18c708bfad5ef1")
    end

    def upload_key(prefix = '')
      "uploads/photo/image/#{subject.id}/#{prefix}#{File.basename(file)}"
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

    context "when the image is still being processed" do
      let(:large_processing_image_url) { path_to("large_default.png") }
      let(:thumb_processing_image_url) { path_to("thumb_default.png") }
      let(:original_processing_image_url) { path_to("original_default.png") }

      before { subject.image_processing=true }

      it "returns the path to the original processing image" do
        expect(subject.url_for(:original)).to eql(original_processing_image_url)
      end

      it "returns the path to a large processing image" do
        expect(subject.url_for(:large)).to eql(large_processing_image_url)
      end

      it "returns the path to a thumb processing image" do
        expect(subject.url_for(:thumb)).to eql(thumb_processing_image_url)
      end

      def path_to(image_filename)
        ActionController::Base.helpers.asset_path(image_filename)
      end
    end
  end
end
