require 'journey'

describe Journey do
  let(:journey) { Journey.new "Victoria"}
  let(:station) {double :station }

  context '#initialize' do

    it "takes a starting station" do
      expect(journey.station_in).to eq "Victoria"
    end

    it "initializes with nil if no entry station" do
      expect(Journey.new.station_in).to eq nil
    end

    it "initializes with an exit station of nil" do
      expect(journey.station_out).to eq nil
    end

  end

  context '#end_journey' do

    it "take an end end station" do
      expect(journey.end_journey(station)).to eq journey.station_out
    end

  end

end
