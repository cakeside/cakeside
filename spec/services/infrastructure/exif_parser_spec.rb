require "rails_helper"

describe ExifParser do
  let(:jpg_with_gps) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }
  let(:jpg_no_gps) { File.join(Rails.root, 'spec/fixtures/images/gorilla.jpg') }
  let(:png_file) { File.join(Rails.root, 'spec/fixtures/images/example.png') }

  it "parses the latitude and longitude" do
    latitude, longitude = subject.parse_geolocation_from(jpg_with_gps)
    expect(latitude).to eql(51.07296369444445)
    expect(longitude).to eql(-114.101799)
  end

  it "ignores png files" do
    latitude, longitude = subject.parse_geolocation_from(png_file)
    expect(latitude).to be_nil
    expect(longitude).to be_nil
  end

  it "ignores jpg files with no gps info" do
    latitude, longitude = subject.parse_geolocation_from(jpg_no_gps)
    expect(latitude).to be_nil
    expect(longitude).to be_nil
  end
end
