class PasswordReset
  def self.send_reset_instructions_to(email)
    user = User.find_by(email: email)
    return if user.nil?
    user.update(reset_password_token: SecureRandom.hex(32), reset_password_sent_at: DateTime.now)
    PasswordResetMailer.delay.send_password_reset_instructions_to(user)
  end

  def self.reset(reset_token, new_password)
    user = User.find_by(reset_password_token: reset_token)
    return if user.nil?
    if user.change_password(new_password)
      user.update(reset_password_token: nil, reset_password_sent_at: nil)
    end
    user
  end
end
