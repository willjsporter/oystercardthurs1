MAX_BALANCE = 90

# in lib/oystercard.rb

class Oystercard
  attr_accessor :balance

  def initialize
    @balance = 10
    @in_use = false


  end

  def top_up(amount)
    raise exceeded_limit if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def exceeded_limit
    raise "Balance cannot exceed #{MAX_BALANCE}"
  end
end
