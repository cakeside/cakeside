require 'rails_helper'

describe Location do
  describe "#create" do
    it 'can create a new location' do
      session = create(:user_session)
      location = Location.create!(latitude: '100', longitude: '100', city: 'Calgary', country: 'Canada', locatable: session)
      expect(location).to_not be_nil
      expect(location.latitude).to eql('100')
      expect(location.longitude).to eql('100')
      expect(location.city).to eql('Calgary')
      expect(location.country).to eql('Canada')
    end
  end
end
