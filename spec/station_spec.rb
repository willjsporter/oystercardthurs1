require 'station'

describe Station do
  describe 'Station' do
    it 'has a name on creation' do
      station = Station.new("aldgate", 2)
      expect(station.name).to eq("aldgate")
    end
    it 'has a zone on creation' do
      station = Station.new("aldgate", 2)
      expect(station.zone).to eq(2)
    end
  end
end
