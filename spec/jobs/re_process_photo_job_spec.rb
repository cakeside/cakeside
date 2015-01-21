require "rails_helper"

describe ReProcessPhotoJob, type: :job do
  subject { ReProcessPhotoJob.new }

  describe "#perform" do
    let(:file_storage) { double(store: true) }
    let(:blob_storage) { double(download: true) }
    let(:photo) { create(:photo) }
    let(:key) { "uploads/photo/image/#{photo.id}/#{photo.image}" }
    let(:file) { double }
    let(:temp_file) { double }

    before :each do
      allow(subject).to receive(:file_storage).and_return(file_storage)
      allow(subject).to receive(:blob_storage).and_return(blob_storage)
    end

    it "processes the original file" do
      allow(blob_storage).to receive(:download).with(key).and_yield(file)
      allow(file_storage).to receive(:store).with(file).and_return(temp_file)
      allow(ProcessPhotoJob).to receive(:perform_later)

      subject.perform(photo)

      expect(ProcessPhotoJob).
        to have_received(:perform_later).
        with(photo, temp_file)
    end
  end
end
