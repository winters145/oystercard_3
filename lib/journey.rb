require_relative './oystercard'
require_relative './station'

class Journey
  
  attr_accessor :list_of_journeys

  def initialize
    @list_of_journeys = []
  end

  def save_journey(entry_station, exit_station)
    @list_of_journeys << { start: entry_station, end: exit_station }
  end
end