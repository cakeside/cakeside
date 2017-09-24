class UserSession < ApplicationRecord
  include Queryable
  belongs_to :user
  has_one :location, as: :locatable
  before_create :set_unique_key
  attr_readonly :key
  scope :active, -> do
    where("accessed_at >= ?", 20.minutes.ago)
      .where("created_at >= ?", 1.day.ago)
      .where(revoked_at: nil)
      .includes(:user)
  end

  def revoke!
    self.revoked_at = Time.current
    save!
  end

  def access(request)
    self.accessed_at = Time.current
    self.ip = request.ip
    self.user_agent = request.user_agent
    self.location = Location.build_from_ip(request.ip)
    save ? key : nil
  end

  def browser
    @browser ||= BrowserSniffer.new(user_agent)
  end

  class << self
    def authenticate(key)
      return nil if key.blank?
      self.active.find_by(key: key)
    end

    def sweep(time = 1.day)
      delete_all("accessed_at < ?", time.ago)
    end
  end

  private

  def set_unique_key
    self.key = SecureRandom.urlsafe_base64(32)
  end
end
