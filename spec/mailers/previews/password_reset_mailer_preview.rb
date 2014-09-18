class PasswordResetMailerPreview < ActionMailer::Preview
  def send_password_reset_instructions_to
    PasswordResetMailer.send_password_reset_instructions_to(User.new(name: 'johnny blaze', reset_password_token: SecureRandom.hex(32)))
  end
end
