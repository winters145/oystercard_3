require_relative '../lib/journey'
require_relative '../lib/oystercard'

describe Journey do
  
  # let(:card) { double Oystercard.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:last_journey){ {start: entry_station, end: exit_station} }

  describe 'on initialize when created' do

    it 'has an empty list of journeys' do 
      expect(subject.list_of_journeys).to be_empty
    end

  end

  describe '#save_journey' do 

    it 'saves the journey to the list_of_journeys' do
      card = Oystercard.new
      card.top_up(50)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey.list_of_journeys).to include last_journey
    end
  end

end