require_relative './journey'
require_relative './station'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE_FOR_JOURNEY = 1
  attr_reader :balance, :list_of_journeys
  attr_accessor :entry_station, :exit_station, :journey
  def initialize
    @balance = 0
    # @list_of_journeys = []
    @in_journey = false
  end

  def top_up(amount)
    raise "Unable to top up: maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Touch in failed: Insufficient balance for journey' if @balance < MINIMUM_BALANCE_FOR_JOURNEY
    @journey = Journey.new
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE_FOR_JOURNEY)
    @journey.save_journey(entry_station, exit_station)
    @entry_station = nil
  end

  def in_journey?
    return !@entry_station.nil?
    false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  # def save_journey(exit_station)
  #   @list_of_journeys << { start: entry_station, end: exit_station }
  # end
end
