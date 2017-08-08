MAX_BALANCE = 90

# in lib/oystercard.rb
class Oystercard
  attr_accessor :balance

  def initialize
    @balance = 10
  end

  def top_up(amount)
    raise exceeded_limit if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct; end

  def exceeded_limit
    raise "Balance cannot exceed #{MAX_BALANCE}"
  end
end
