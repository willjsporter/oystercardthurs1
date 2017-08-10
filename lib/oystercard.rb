MAX_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

# in lib/oystercard.rb

class Oystercard
  attr_reader :balance, :entry_station, :journey, :trip_history

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @journey = {}
    @trip_history = []
  end

  def top_up(amount)
    raise "Balance cannot exceed #{MAX_BALANCE}" if exceeded_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station = nil) # set as no class is created
    raise 'Insufficient funds' if insufficient_funds?
    raise 'error, you have already tapped in' unless @entry_station.nil?
    @entry_station = station  #  station = Station.new
    @journey[@entry_station] = 'not touched out yet'
  end

  def touch_out(station = nil)
    deduct(MINIMUM_FARE)
    # @entry_station = nil
    @journey[@entry_station] = station
    @trip_history << @journey
    @journey = {}
  end

  private

  def exceeded_limit?(amount)
    @balance + amount > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
