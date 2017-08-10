class Journey

  attr_reader :station_in, :station_out

  def initialize(station_in = "Didn't tap in")
    @station_in = station_in
    @station_out = nil
  end

  def end_journey(station)
    @station_out = station
  end

  def add_history(ary)
    ary << {@station_in.intern => @station_out}
  end

end
