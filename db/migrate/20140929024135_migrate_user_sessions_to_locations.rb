class MigrateUserSessionsToLocations < ActiveRecord::Migration
  def change
    UserSession.find_each do |session|
      location = Location.build_from_ip(session.ip)
      location.locatable = session
      location.save
    end
  end
end
