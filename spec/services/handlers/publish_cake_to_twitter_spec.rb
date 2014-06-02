require "spec_helper"

describe PublishCakeToTwitter do
  let(:twitter) { double(tweet: '') }
  let(:cakes) { double }

  subject { PublishCakeToTwitter.new(twitter, cakes) }

  describe "#handles?" do
    it "handles cake_published" do
      subject.handles?(:cake_published).should be_true
    end
  end

  describe "#handle" do
    let(:artist) { User.new(name: 'joe') }
    let(:cake) { Creation.new(id: id, name: 'yummy') }
    let(:id) { 88 }

    before :each do
      cake.stub(:user).and_return(artist)
      cakes.stub(:find).with(id).and_return(cake)
    end

    context "when the cake is published and safe for kids" do
      before :each do
        cake.stub(:is_safe_for_children?).and_return(true)
        cake.stub(:published?).and_return(true)
      end

      it "tweets new cakes" do
        subject.handle(cake_id: id)
        twitter.should have_received(:tweet).with("yummy By joe on http://www.blah.com/creations/88-yummy!")
      end
    end

    context "when the cake is not published" do
      before :each do
        cake.stub(:is_safe_for_children?).and_return(true)
        cake.stub(:published?).and_return(false)
      end

      it "should not publish any tweets" do
        subject.handle(cake_id: id)
        twitter.should_not have_received(:tweet)
      end
    end

    context "when the cake is not safe for children" do
      before :each do
        cake.stub(:is_safe_for_children?).and_return(false)
        cake.stub(:published?).and_return(true)
      end

      it "should not publish any tweets" do
        subject.handle(cake_id: id)
        twitter.should_not have_received(:tweet)
      end
    end
  end
end
