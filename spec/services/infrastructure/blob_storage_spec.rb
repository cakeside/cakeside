require "rails_helper"

describe BlobStorage do
  let(:bucket) { ENV['FOG_DIRECTORY'] }
  subject { BlobStorage.new }

  let(:file) { File.join(Rails.root, 'spec/fixtures/images/gorilla.jpg') }

  context "when uploading" do
    it "uploads to s3" do
      key = "test#{SecureRandom.uuid}"
      subject.upload(key, file)

      object = AWS::S3.new.buckets[bucket].objects[key]
      expect(object.exists?).to be_truthy
    end
  end

  describe "#download" do
    let(:key) { "test#{SecureRandom.uuid}" }

    it 'downloads a file from blob storage' do
      subject.upload(key, file)

      sha = subject.download(key) do |temp_file|
        Digest::SHA256.file(temp_file.path).hexdigest
      end
      expect(sha).to eql(Digest::SHA256.file(file).hexdigest)
    end
  end
end
