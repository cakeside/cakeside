require 'rails_helper'

describe User do
  describe "#properties" do
    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :twitter }
    it { should respond_to :facebook }
    it { should respond_to :city }
    it { should respond_to :password }
    it { should respond_to :website }
    it { should respond_to :interests }
    it { should respond_to :creations }
    it { should respond_to :favorites }
    it { should respond_to :tutorials }
    it { should respond_to :avatar }
  end

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
        user.errors[:website].any?.should == false
      end

      it "should not have any validation error messages" do
        user.errors[:website].should === []
      end
    end

    describe "when the url is not valid" do
      let(:user) { User.new }

      before(:each) { user.update_attributes(:website => 'blah') }

      it "cannot validate" do
        user.errors[:website].any?.should == true
      end

      it "should have an error message" do
        user.errors[:website].should === ["is invalid"]
      end
    end
  end

  describe "when checking if a user already likes a creation" do
    let(:sut) { create(:user) }
    let(:cake) { create(:creation) }

    describe "when they do" do
      before :each do
        sut.add_favorite(cake)
      end

      let(:result) { sut.already_likes(cake) }

      it "should return true" do
        result.should be_truthy
      end
    end

    describe "when they do not" do
      let(:result) { sut.already_likes(cake) }

      it "should return false" do
        result.should be_falsey
      end
    end
  end

  describe "when a user adds a cake to their favorites" do
    let(:sut) { create(:user) }
    let!(:cake) { create(:creation) }

    context "when the cake is already in their favorites" do
      let!(:favorite) { create(:favorite, :creation => cake, :user => sut) }
      let(:result) { sut.add_favorite(cake) }

      it "should return their existing favorite" do
        result.should == favorite
      end
    end

    context "when they have not liked it before" do
      let(:result) { sut.add_favorite(cake) }

      it "should return a new favorite" do
        result.should be_a(Favorite)
      end

      it "should specify the user" do
        result.user.should == sut
      end

      it "should specify the creation" do
        result.creation.should == cake
      end
    end
  end

  describe "send welcome email" do
    let(:user) { build(:user) }
    let(:mailer) { double("mailer", welcome_email: true) }

    before :each do
      UserMailer.stub(:delay).and_return(mailer)
      user.send_welcome_email
    end

    it "should send the email" do
      mailer.should have_received(:welcome_email).with(user)
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
