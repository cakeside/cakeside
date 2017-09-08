class UserSession < ActiveRecord::Base
  include Queryable
  belongs_to :user
  has_one :location, as: :locatable
  before_create :set_unique_key
  attr_readonly :key
  scope :active, -> { where("accessed_at >= ?", 2.weeks.ago).where(revoked_at: nil).includes(:user) }

  def revoke!
    self.revoked_at = Time.now
    save!
  end

  def access(request)
    self.accessed_at = Time.now
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
  end

  private

  def set_unique_key
    self.key = SecureRandom.urlsafe_base64(32)
  end
end
