require 'rails_helper'

RSpec.describe ProcessAvatarJob, type: :job do
  subject { ProcessAvatarJob.new }

  describe "#perform" do
    let(:blob_storage) { double }
    let(:user) { build(:user)  }
    let(:file_path) { '/Users/blah/eicar' }
    let(:avatar) { Photo.new }

    before :each do
      allow(subject).to receive(:blob_storage).and_return(blob_storage)
    end

    it 'uploads the new avatar' do
      allow(Photo).to receive(:create!).and_return(avatar)
      allow(avatar).to receive(:upload)
      allow(avatar).to receive(:save!)

      subject.perform(user, file_path)

      expect(avatar).to have_received(:upload).with(file_path, blob_storage)
      expect(avatar).to have_received(:save!)
    end
  end
end
