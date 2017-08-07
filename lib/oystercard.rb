# in lib/oystercard.rb
class Oystercard
  attr_accessor :balance

  def initialize
    @balance = 10
  end

  def top_up(amount)
    @balance += amount
    @balance
  end
end
