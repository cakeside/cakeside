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
    context "when the cake is published and safe for kids" do
      let(:artist) { User.new(name: 'joe') }
      let(:cake) { Creation.new(id: id, name: 'yummy') }
      let(:id) { 88 }

      before :each do
        Rails.application.routes.default_url_options[:host]= 'localhost:3000' 
        cake.stub(:is_safe_for_children?).and_return(true)
        cake.stub(:published?).and_return(true)
        cake.stub(:user).and_return(artist)
        cakes.stub(:find).with(id).and_return(cake)
      end

      it "tweets new cakes" do
        subject.handle(cake_id: id)
        twitter.should have_received(:tweet).with("yummy By joe on http://localhost:3000/creations/88-yummy!")
      end
    end
  end
end
