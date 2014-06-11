require "rails_helper"

describe UserMailer do
  context "send welcome email" do
    let(:user) { build(:user) }
    let(:mail) { UserMailer.welcome_email(user) }

    it "adds a subject" do
      mail.subject.should == "Welcome to CakeSide"
    end

    it "sends to the users email" do
      mail.to.should include user.email
    end

    it "should send from the correct address" do
      mail.from.should include 'noreply@cakeside.com'
    end

    it "includes their name" do
      mail.body.encoded.should match(user.name)
    end
  end
end
