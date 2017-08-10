class Journey

  def initialize(station_in = nil)
    @station_in = station_in
    @station_out = nil
  end

  attr_reader :station_in, :station_out

end
