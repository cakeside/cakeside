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
    let(:image_path) { File.join(Rails.root, 'spec/fixtures/images/example.png') }
    let(:photo) { Photo.new(id: rand(100)) }

    before :each do
      photos.stub(:find).with(photo.id).and_return(photo)
    end

    it "saves the uploaded image" do
      message = {
        photo_id: photo.id,
        file_path: image_path,
        content_type: 'image/jpeg',
        original_filename: 'blah.jpg'
      }
      subject.handle(message)
      photo.image.should_not be_nil
    end
  end
end

