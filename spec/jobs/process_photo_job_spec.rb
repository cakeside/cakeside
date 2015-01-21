require 'rails_helper'

RSpec.describe ProcessPhotoJob, :type => :job do
  subject { ProcessPhotoJob.new }

  describe "#perform" do
    let(:blob_storage) { double(upload: true) }
    let(:image_path) { File.join(Rails.root, 'spec/fixtures/images/gps.jpg') }
    let(:photo) { double(upload: true, save!: true) }

    before :each do
      allow(subject).to receive(:storage).and_return(blob_storage)
    end

    it "saves the uploaded image" do
      subject.perform(photo, image_path)
      expect(photo).to have_received(:upload).with(image_path, blob_storage)
      expect(photo).to have_received(:save!)
    end
  end
end
