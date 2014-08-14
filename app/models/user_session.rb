class UserSession < ActiveRecord::Base
  belongs_to :user
  before_validation :set_unique_key
  scope :active, -> { where("accessed_at >= ?", 2.weeks.ago).where(revoked_at: nil) }

  def revoke!
    self.revoked_at = Time.now
    save!
  end

  def access(request)
    self.accessed_at = Time.now
    self.ip = request.ip
    self.user_agent = request.user_agent
    save
  end

  private

  def set_unique_key
    self.key = SecureRandom.urlsafe_base64(32)
  end

  class << self
    def authenticate(key)
      self.active.find_by(key: key)
    end

    def login(username, password)
      user = User.find_by(email: username)
      return false if user.nil?
      bcrypt = ::BCrypt::Password.new(user.encrypted_password)
      password = ::BCrypt::Engine.hash_secret("#{password}#{User.pepper}", bcrypt.salt)
      if secure_compare(password, user.encrypted_password)
        create!(user: user)
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
