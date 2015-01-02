require 'rails_helper'

describe User do
  describe "validations" do
    subject { build(:user) }

    it 'validates the email' do
      subject.email = 'blah'
      expect(subject.valid?).to be_falsey
      expect(subject.errors[:email]).to_not be_empty
    end

    it 'validates the presence of the email' do
      subject.email = nil
      expect(subject.valid?).to be_falsey
      expect(subject.errors[:email]).to_not be_empty
    end

    it 'validates the presence of a password' do
      subject.password = nil
      expect(subject.valid?).to be_falsey
      expect(subject.errors[:password]).to_not be_empty
    end
  end

  describe "when a website url is supplied" do
    describe "when the url is valid" do
      let(:user) { build(:user) }

      before(:each) { user.update_attribute(:website, 'http://example.com') }

      it "can validate" do
        expect(user.errors[:website].any?).to be_falsey
      end

      it "should not have any validation error messages" do
        expect(user.errors[:website]).to be_empty
      end
    end

    describe "when the url is not valid" do
      let(:user) { User.new }

      before(:each) { user.update(website: 'blah') }

      it "cannot validate" do
        expect(user.errors[:website].any?).to be_truthy
      end

      it "should have an error message" do
        expect(user.errors[:website]).to match_array(["is invalid"])
      end
    end
  end

  describe "when checking if a user already likes a creation" do
    subject { create(:user) }
    let(:cake) { create(:creation) }

    describe "when they do" do
      it "returns true" do
        subject.add_favorite(cake)
        expect(subject.already_likes(cake)).to be_truthy
      end
    end

    describe "when they do not" do
      let(:result) { subject.already_likes(cake) }

      it "should return false" do
        expect(subject.already_likes(cake)).to be_falsey
      end
    end
  end

  describe "when a user adds a cake to their favorites" do
    subject { create(:user) }
    let!(:cake) { create(:creation) }

    context "when the cake is already in their favorites" do
      let!(:favorite) { create(:favorite, creation: cake, user: subject) }

      it "should return their existing favorite" do
        expect(subject.add_favorite(cake)).to eql(favorite)
      end
    end

    context "when they have not liked it before" do
      let(:result) { subject.add_favorite(cake) }

      it "should return a new favorite" do
        expect(result).to be_a(Favorite)
      end

      it "should specify the user" do
        expect(result.user).to eql(subject)
      end

      it "should specify the creation" do
        expect(result.creation).to eql(cake)
      end
    end
  end

  describe "send welcome email" do
    let(:user) { build(:user) }
    let(:mailer) { double("mailer", deliver_later: true) }

    before :each do
      allow(UserMailer).to receive(:welcome_email).with(user).and_return(mailer)
      user.send_welcome_email
    end

    it "should send the email" do
      expect(mailer).to have_received(:deliver_later)
    end
  end

  describe ".login" do
    context "when the email is not known" do
      it "returns false" do
        expect(User.login('blah@example.com', 'password')).to be_falsey
      end
    end

    context "when the email is known" do
      let(:user) { create(:user) }

      before :each do
        user.password = 'password'
        user.save!
      end

      context "when the password is incorrect" do
        it "returns false" do
          expect(User.login(user.email, 'blah')).to be_falsey
        end
      end

      context "when the password is correct" do
        it "returns a new session" do
          result = User.login(user.email, 'password')
          expect(result).to be_truthy
          expect(result).to_not be_new_record
          expect(result.user).to eql(user)
        end
      end
    end
  end
end
