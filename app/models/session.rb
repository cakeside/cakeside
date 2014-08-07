class Session
  attr_accessor :id

  def persisted?
  end

  class << self
    def login(username, password)
      user = User.find_by(email: username)
      return false if user.nil?
      bcrypt = ::BCrypt::Password.new(user.encrypted_password)
      password = ::BCrypt::Engine.hash_secret("#{password}#{User.pepper}", bcrypt.salt)
      if secure_compare(password, user.encrypted_password)
        #Session.create!(user: user)
      else
        false
      end
    end

    # constant-time comparison algorithm to prevent timing attacks
    def secure_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end
  end
end
