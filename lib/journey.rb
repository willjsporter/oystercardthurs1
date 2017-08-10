class Journey

  attr_reader :station_in, :station_out

  def initialize(station_in = nil)
    @station_in = station_in
    @station_out = nil
  end

  def end_journey(station)
    @station_out = station
  end

end
