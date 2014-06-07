require "spec_helper"

describe Image do
  describe "#filename" do
    it "returns the filename" do
      expect(Image.new("/Users/mo/blah.png").filename).to eql("blah.png")
    end

    it "sanitizes the filename" do
      expect(Image.new("/Users/mo/blah huh.png").filename).to eql("blah_huh.png")
    end

    it "gives the SHA256 of the image" do
      path = File.join(Rails.root, 'spec/fixtures/images/gps.jpg')
      expect(Image.new(path).sha256).to eql('a1b1b9b8b22d3a4a3523ebb0dc2c57c685938427e12e8a6439fbab104da6b1d8')
    end
  end
end
