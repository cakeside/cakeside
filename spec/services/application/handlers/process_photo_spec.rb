require "spec_helper"

describe ProcessPhoto do
  let(:photos) { double }
  let(:blob_storage) { double(upload: true) }
  subject { ProcessPhoto.new(photos, blob_storage) }

  describe "#handles?" do
    it "handles photo uploads" do
      subject.handles?(:upload_photo).should be_truthy
    end
  end

  describe "#handle" do
    let(:image_path) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }
    let(:photo) { double(upload: true, save!: true) }

    before :each do
      photos.stub(:find).with(1).and_return(photo)
      message = {
        photo_id: 1,
        file_path: image_path,
        content_type: 'image/jpeg',
      }
      subject.handle(message)
    end

    it "saves the uploaded image" do
      expect(photo).to have_received(:upload).with(image_path, blob_storage)
      expect(photo).to have_received(:save!)
    end
  end
end
