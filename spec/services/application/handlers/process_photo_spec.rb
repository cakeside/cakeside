require "spec_helper"

describe ProcessPhoto do
  let(:photos) { double }
  subject { ProcessPhoto.new(photos) }

  describe "#handles?" do
    it "handles photo uploads" do
      subject.handles?(:upload_photo).should be_true
    end
  end

  describe "#handle" do
    let(:image_path) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }
    let(:photo) { Photo.new(id: rand(100), image_processing: true) }

    before :each do
      photos.stub(:find).with(photo.id).and_return(photo)
      message = {
        photo_id: photo.id,
        file_path: image_path,
        content_type: 'image/jpeg',
        original_filename: 'blah.jpg'
      }
      subject.handle(message)
    end

    it "saves the uploaded image" do
      photo.image.should_not be_nil
    end

    it "indicates that the photo has been processed." do
      photo.image_processing.should be_false
    end

    it "specifies the content type" do
      photo.content_type.should == 'image/jpeg'
    end

    it "specifies the original filename" do
      photo.original_filename.should == 'blah.jpg'
    end

    it "applies the geolocation information" do
      photo.latitude.should == 51.07296369444445
      photo.longitude.should == -114.101799
    end

    xit "ignore geolocation for files that dont have geolocation info" do
      
    end
  end
end

