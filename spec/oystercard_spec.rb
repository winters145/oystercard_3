require_relative '../lib/oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey){ {start: entry_station, end: exit_station} }

  describe 'initialized when created' do
    it 'has a balance of zero' do
      expect(card.balance).to eq(0)
    end
    # it 'has an empty list of journeys' do 
    #   expect(card.list_of_journeys).to be_empty
    # end
  end

  describe '#top_up' do
    it 'balance of card should increase by given value' do
      expect { card.top_up 10 }.to change { card.balance }.by 10
    end

    it 'should raise an error if the top_up amount takes the balance greater than maximum' do
      expect do
        card.top_up(Oystercard::MAXIMUM_BALANCE + 1)
      end.to raise_error "Unable to top up: maximum balance is £#{Oystercard::MAXIMUM_BALANCE}"
    end
  end
  context 'when in_journey' do

    before do 
      card.top_up(50)
      card.touch_in(entry_station)
    end

    describe '#touch_in' do
      it 'should change the in_journey? status of the card to true' do
        expect(card.in_journey?).to eq true
      end
  
      it 'should remember the entry_station upon touch_in' do
        expect(card.entry_station).to eq entry_station
      end
    end
  
    describe '#touch_out' do
      it 'should change the in_journey status of the card to false' do
        card.touch_out(exit_station)
        expect(card.in_journey?).to eq false
      end
      it 'should take an exit_station as an argument' do
        expect(card).to respond_to(:touch_out).with(1).argument
      end
      it 'should deduct the MINIMUM_BALANCE_FOR_JOURNEY when user touches out' do
        expect { card.touch_out(exit_station) }.to change { card.balance }.by(- Oystercard::MINIMUM_BALANCE_FOR_JOURNEY)
      end
      it 'should set the entry_station variable to nil upon touch_out(exit_station)' do
        card.touch_out(exit_station)
        expect(card.entry_station).to eq nil
      end
      # it 'should save the journey to the list_of_journeys' do
      #   card.touch_out(exit_station)
      #   expect(card.list_of_journeys).to include journey
      # end
    end

    describe '#in_journey?' do
      it 'should return false when entry_station is equal to nil' do
       card.touch_out(exit_station)
       expect(card.in_journey?).to eq false
      end
    end
  end
  context 'has less than £1 balance' do
    it 'should raise an error when trying to touch_in' do
      expect { card.touch_in(entry_station) }.to raise_error 'Touch in failed: Insufficient balance for journey'
    end
  end  
end
