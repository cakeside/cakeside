require "rails_helper"

describe UserSession do
  subject { build(:user_session) }

  describe "#revoke!" do
    it "records the time the session was revoked" do
      subject.revoke!
      expect(subject.revoked_at).to_not be_nil
    end
  end

  describe "#access" do
    let(:request) { double(ip: '192.168.1.1', user_agent: 'blah') }
    let!(:because) { subject.access(request) }

    it "records the time the session was accessed" do
      expect(subject.accessed_at).to_not be_nil
    end

    it "records the ip address of the request" do
      expect(subject.ip).to eql(request.ip)
    end

    it "records the user agent of the request" do
      expect(subject.user_agent).to eql(request.user_agent)
    end

    it "returns a hash to store in the cookie" do
      expect(because[:value]).to eql(subject.key)
      expect(because[:httponly]).to be_truthy
      expect(because[:expires].to_i).to eql(2.weeks.from_now.to_i)
    end
  end

  describe ".active" do
    let!(:active_session) { create(:user_session, accessed_at: Time.now) }
    let!(:expired_session) { create(:user_session, accessed_at: 15.days.ago) }
    let!(:revoked_session) { create(:user_session, accessed_at: 1.day.ago, revoked_at: Time.now) }

    it "returns active sessions" do
      expect(UserSession.active).to include(active_session)
    end

    it "excludes expired sessions" do
      expect(UserSession.active).to_not include(expired_session)
    end

    it "excludes revoked sessions" do
      expect(UserSession.active).to_not include(revoked_session)
    end
  end

  describe ".authenticate" do
    let!(:active_session) { create(:user_session, accessed_at: Time.now) }

    it "returns the session if the key is active" do
      expect(UserSession.authenticate(active_session.key)).to eql(active_session)
    end

    it "return nil if the key is not active" do
      expect(UserSession.authenticate('blah')).to be_nil
    end
  end
end
