require "spec_helper"

describe ExifParser do
  let(:jpg_with_gps) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }
  let(:jpg_no_gps) { File.join(Rails.root, 'spec/fixtures/images/gorilla.jpg') }
  let(:png_file) { File.join(Rails.root, 'spec/fixtures/images/example.png') }

  it "parses the latitude and longitude" do
    latitude, longitude = subject.parse_geolocation_from(jpg_with_gps)
    latitude.should == 51.07296369444445
    longitude.should == -114.101799
  end

  it "ignores png files" do
    latitude, longitude = subject.parse_geolocation_from(png_file)
    latitude.should be_nil
    longitude.should be_nil
  end

  it "ignores jpg files with no gps info" do
    latitude, longitude = subject.parse_geolocation_from(jpg_no_gps)
    latitude.should be_nil
    longitude.should be_nil
  end
end
