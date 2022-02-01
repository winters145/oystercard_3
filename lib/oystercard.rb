class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE_FOR_JOURNEY = 1
  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Unable to top up: maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Touch in failed: Insufficient balance for journey" if @balance < MINIMUM_BALANCE_FOR_JOURNEY
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_BALANCE_FOR_JOURNEY)
    @entry_station = nil
  end

  def in_journey?
    return false if @entry_station == nil
    true
  end
  
  private

  def deduct(amount)
    @balance -= amount
  end
end
