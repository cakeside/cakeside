require "spec_helper"

describe Image do
  describe "#filename" do
    it "returns the filename" do
      expect(Image.new("/Users/mo/blah.png").filename).to eql("blah.png")
    end

    it "sanitizes the filename" do
      expect(Image.new("/Users/mo/blah huh.png").filename).to eql("blah_huh.png")
    end
  end
end
