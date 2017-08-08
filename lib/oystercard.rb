MAX_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

# in lib/oystercard.rb

class Oystercard
  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_use = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "Balance cannot exceed #{MAX_BALANCE}" if exceeded_limit?(amount)
    @balance += amount
  end

  def in_journey?
    @in_use
  end

  def touch_in(station = nil)
    raise 'Insufficient funds' if insufficient_funds?
    @entry_station = station
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @in_use = false
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
