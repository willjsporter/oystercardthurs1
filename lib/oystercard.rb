require 'station'
require 'journey'

MAX_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0
PENALTY_FARE = 8

# in lib/oystercard.rb


class Oystercard
  attr_reader :balance, :current_journey, :trip_history

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    #@entry_station = nil
    @trip_history = []
    @current_journey = nil
  end

  def current_journey
    @current_journey
  end

  def top_up(amount)
    raise "Balance cannot exceed #{MAX_BALANCE}" if exceeded_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station) # set as no class is created
    raise 'Insufficient funds' if insufficient_funds?
    # raise 'error, you have already tapped in' unless @entry_station.nil?
    (deduct(PENALTY_FARE); @current_journey.add_history(@trip_history)) unless current_journey.nil?
    #@current_journey.add_history(@trip_history) unless @current_journey.nil?
    # @entry_station = station  #  
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
    #@trip_history.last.keys[0]
    # @entry_station = nil
    #@journey[@entry_station] = station # entry station is nil ? @journey[:noentrystation]=station
    #@trip_history << @journey
    #@entry_station = nil
    #@journey = {}
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
