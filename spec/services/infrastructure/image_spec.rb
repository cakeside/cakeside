require "rails_helper"

describe Image do
  describe "#filename" do
    it "returns the filename" do
      expect(Image.new("/Users/mo/blah.png").filename).to eql("blah.png")
    end

    it "sanitizes the filename" do
      expect(Image.new("/Users/mo/blah huh.png").filename).to eql("blah_huh.png")
    end
  end

  describe "#sha256" do
    let(:path) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }

    it "gives the SHA256 of the image" do
      expect(Image.new(path).sha256).to eql("530990323da10ba4b8ab6a9809e9d694bd354831fd58afc96e18c708bfad5ef1")
    end
  end

  describe "#geolocation" do
    let(:exif) { double }
    subject { Image.new('blah.jpg', exif) }

    it "parses the geolocation info" do
      coordinates = [rand(100), rand(50)]
      allow(exif).to receive(:parse_geolocation_from).with('blah.jpg').and_return(coordinates)
      expect(subject.geolocation).to eql(coordinates)
    end
  end

  describe "#content_type" do
    it "returns the correct content type for jpegs" do
      expect(Image.new('blah.jpg').content_type).to eql('image/jpeg')
      expect(Image.new('blah.jpeg').content_type).to eql('image/jpeg')
    end

    it "returns the correct content type for png" do
      expect(Image.new('blah.png').content_type).to eql('image/png')
    end

    it "returns the correct content type for gif" do
      expect(Image.new('blah.gif').content_type).to eql('image/gif')
    end

    it "returns the correct content type for bmp" do
      expect(Image.new('blah.bmp').content_type).to eql('image/bmp')
    end

    it "returns the correct content type for tif" do
      expect(Image.new('blah.tif').content_type).to eql('image/tiff')
    end
  end

  it "raises an errorwhen the file is not in the whitelist" do
    expect(-> { Image.new('blah.exe') }).to raise_error(/not in the whitelist/)
  end

  context "resizing" do
    let(:path) { "#{Tempfile.new('gps').path}.jpg" }
    subject { Image.new(path) }

    before :each do
      FileUtils.cp(File.join(Rails.root, 'spec/fixtures/images/gps.jpg'), path)
    end

    it "resizes the image to fit" do
      subject.resize_to_fit(width: 570, height: 630)

      image = MiniMagick::Image.open(path)
      expect(image[:width]).to eql(473)
      expect(image[:height]).to eql(630)
    end

    it "resizes the image to fill" do
      subject.resize_to_fill(width: 130, height: 90)

      image = MiniMagick::Image.open(path)
      expect(image[:width]).to eql(130)
      expect(image[:height]).to eql(90)
    end

    it "adds a watermark" do
      expect(-> { subject.watermark("testing") }).to_not raise_error
      #`open #{path}`
    end
  end
end
