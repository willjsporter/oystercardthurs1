require 'station'
require 'journey'

MAX_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0
PENALTY_FARE = 8

class Oystercard
  attr_reader :balance, :trip_history, :current_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @trip_history = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Balance cannot exceed #{MAX_BALANCE}" if exceeded_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station)
    raise 'Insufficient funds' if insufficient_funds?
    (deduct(PENALTY_FARE); @current_journey.add_history(@trip_history)) unless current_journey.nil?
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    if @current_journey.nil?
      @current_journey = Journey.new
      deduct(PENALTY_FARE)
    else
      deduct(MINIMUM_FARE)
    end
    @current_journey.end_journey(station)
    @current_journey.add_history(@trip_history)
    @current_journey = nil
  end

  def exceeded_limit?(amount)
    @balance + amount > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

  private :exceeded_limit?, :insufficient_funds?, :deduct
end
