module DeviseHelper
  module Controllers
    def http_login(user)
      gateway = double
      gateway.stub(:authenticate).and_return(user)
      gateway.stub(:authenticate!).and_return(user)
      gateway.stub(:authenticate?).and_return(user)
      request.env['warden'] = gateway
    end
  end
end
