require 'journey'

describe Journey do
  let(:journey) { Journey.new "Victoria" }
  let(:station) { double :station }
  let(:station1) { double :station1 }

  context '#initialize' do

    it "takes a starting station" do
      expect(journey.station_in).to eq "Victoria"
    end

    it "initializes with 'didn't tap in' if no entry station" do
      expect(Journey.new.station_in).to eq "Didn't tap in"
    end

    it "initializes with an exit station of nil" do
      expect(journey.station_out).to eq nil
    end

  end

  context 'end_journey' do

    it "take an end end station" do
      expect(journey.end_journey(station)).to eq journey.station_out
    end

  end

  context 'add to journey array' do

    it "can add journey hash to an array" do
      ary = [1]
      journey.end_journey(station1)
      journey.add_history(ary)
      expect(ary[1].class).to eq Hash
    end

    it "records journey start in hash key" do
      ary = [1]
      journey.end_journey(station1)
      journey.add_history(ary)
      expect(ary[1].keys.first).to eq :Victoria
    end

    it "records journey end in hash value" do
      ary = [1]
      journey.end_journey(station1)
      journey.add_history(ary)
      expect(ary[1].values.first).to eq station1
    end

  end

end
