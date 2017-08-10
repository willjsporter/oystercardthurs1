require 'journey'

describe Journey do
  let(:journey) { Journey.new "Victoria"}

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
