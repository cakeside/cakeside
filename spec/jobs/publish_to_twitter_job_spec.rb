require 'rails_helper'

RSpec.describe PublishToTwitterJob, :type => :job do
  subject { PublishToTwitterJob.new }

  describe "#perform" do
    let(:artist) { User.new(name: 'joe') }
    let(:cake) { Creation.new(id: id, name: 'yummy') }
    let(:id) { 88 }
    let(:twitter) { double(tweet: '') }
    let(:cakes) { double }

    before :each do
      allow(cake).to receive(:user).and_return(artist)
      allow(cakes).to receive(:find).with(id).and_return(cake)
      allow(subject).to receive(:twitter).and_return(twitter)
    end

    context "when the cake is published and safe for kids" do
      before :each do
        allow(cake).to receive(:published?).and_return(true)
      end

      it "tweets about the new cake" do
        subject.perform(cake)
        expect(twitter).to have_received(:tweet).with("yummy By joe on http://www.blah.com/cakes/88-yummy!")
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
