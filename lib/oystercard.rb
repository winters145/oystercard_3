class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE_FOR_JOURNEY = 1
  attr_reader :balance
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Unable to top up: maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Touch in failed: Insufficient balance for journey" if @balance < MINIMUM_BALANCE_FOR_JOURNEY
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_BALANCE_FOR_JOURNEY)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
