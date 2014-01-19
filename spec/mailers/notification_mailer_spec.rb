require "spec_helper"

describe NotificationMailer do
  context "send welcome email" do
    let(:activity) { build(:activity) }
    let(:mail) { NotificationMailer.notification_email(activity) }

    it "adds a subject" do
      mail.subject.should == "New Activity on CakeSide"
    end

    it "sends to the users email" do
      mail.to.should include activity.user.email
    end

    it "should send from the correct address" do
      mail.from.should include 'noreply@cakeside.com'
    end

    it "includes their name" do
      mail.body.encoded.should match(activity.user.name)
    end
  end
end
