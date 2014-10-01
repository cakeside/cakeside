class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true
  validates :locatable, presence: true

  GEO_IP=GeoIP.new('config/GeoLiteCity.dat')

  class << self
    def build_from_ip(ip)
      city = GEO_IP.city(ip)
      return nil unless city
      Location.new(
        latitude: city.latitude,
        longitude: city.longitude,
        city: city.city_name,
        country: city.country_name
      )
    end
  end
end
