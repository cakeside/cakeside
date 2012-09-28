module DeviseHelper
  def http_login(user)
    gateway = fake
    gateway.stub(:authenticate).and_return(user)
    gateway.stub(:authenticate!).and_return(user)
    request.env['warden'] = gateway
  end
end
