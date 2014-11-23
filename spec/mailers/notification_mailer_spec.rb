require "rails_helper"

describe NotificationMailer do
  context "send welcome email" do
    let(:user) { build(:user) }
    let(:mail) { NotificationMailer.notification_email(user) }

    it "adds a subject" do
      mail.subject.should == "New Activity on CakeSide"
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
