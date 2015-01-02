require "rails_helper"

describe NotificationMailer do
  context "send welcome email" do
    let(:user) { build(:user) }
    let(:mail) { NotificationMailer.notification_email(user) }

    it "adds a subject" do
      expect(mail.subject).to eql("New Activity on CakeSide")
    end

    it "sends to the users email" do
      expect(mail.to).to match_array([user.email])
    end

    it "should send from the correct address" do
      expect(mail.from).to match_array(['noreply@cakeside.com'])
    end

    it "includes their name" do
      expect(mail.body.encoded).to match(user.name)
    end
  end
end
