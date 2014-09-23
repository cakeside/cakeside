require "rails_helper"

describe ApplicationHelper do
  describe "#disqus_auth" do
    let(:user) { create(:user) }
    let(:secret) { 'secret' }

    let(:expected) do
      data = { id: user.id, username: user.name, email: user.email, url: "https://test.host/profiles/#{user.to_param}" }.to_json
      message = Base64.encode64(data).gsub("\n", "")
      timestamp = Time.now.to_i
      signature = OpenSSL::HMAC.hexdigest('sha1', secret, "#{message} #{timestamp}")
      "#{message} #{signature} #{timestamp}"
    end

    before { ENV['DISQUS_SECRET_KEY'] = secret }

    it "should generate a single sign on token" do
      expect(helper.disqus_auth(user)).to eql(expected)
    end
  end
end
