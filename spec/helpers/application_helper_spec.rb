require "spec_helper"

describe ApplicationHelper do
  describe :disqus_auth do
    let(:user) { OpenStruct.new(id: 1, name: 'mo', email: 'test@cakeside.com', :to_param => '1-mo') }

    before :each do
      data = { id: user.id, username: user.name, email: user.email, :url => "https://test.host/profiles/#{user.to_param}" }.to_json
      message = Base64.encode64(data).gsub("\n", "")
      timestamp = Time.now.to_i
      secret = ENV['DISQUS_SECRET_KEY'] = 'secret'
      signature = OpenSSL::HMAC.hexdigest('sha1', secret, "#{message} #{timestamp}")
      @expected = "#{message} #{signature} #{timestamp}"
    end

    it "should generate a single sign on token" do
      result = helper.disqus_auth(user)
      result.should_not be_nil
      result.should == @expected
    end
  end
end
