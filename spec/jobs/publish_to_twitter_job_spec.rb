require 'rails_helper'

RSpec.describe PublishToTwitterJob, :type => :job do
  subject { PublishToTwitterJob.new }

  describe "#perform" do
    let(:artist) { User.new(name: 'joe') }
    let(:cake) { Creation.new(id: 88, name: 'yummy', user: artist) }
    let(:twitter) { double(tweet: '') }

    before :each do
      allow(subject).to receive(:twitter).and_return(twitter)
    end

    context "when the cake is published and safe for kids" do
      before :each do
        allow(cake).to receive(:published?).and_return(true)
      end

      it "tweets about the new cake" do
        subject.perform(cake)
        expect(twitter).to have_received(:tweet).
          with("yummy By joe on http://www.example.com/cakes/88-yummy!")
      end
    end

    context "when the cake is not published" do
      before :each do
        allow(cake).to receive(:published?).and_return(false)
      end

      it "should not publish any tweets" do
        subject.perform(cake)
        expect(twitter).not_to have_received(:tweet)
      end
    end
  end
end
