class AddGeoLocationToUserSessions < ActiveRecord::Migration
  def change
    add_column :user_sessions, :latitude, :float
    add_column :user_sessions, :longitude, :float
    add_column :user_sessions, :city, :string
    add_column :user_sessions, :country, :string
  end
end
