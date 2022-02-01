require_relative '../lib/oystercard.rb'

describe Oystercard do
  let(:entry_station) { double :entry_station }

  describe "#balance"
    it "has a balance of zero" do
      expect(subject.balance).to eq(0)
    end
  
  describe "#top_up" do
    it "balance of card should increase by given value" do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10 
      end

    it "should raise an error if the top_up amount takes the balance greater than maximum" do
      expect { subject.top_up(Oystercard::MAXIMUM_BALANCE+1) }.to raise_error "Unable to top up: maximum balance is £#{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  # describe "#deduct" do
  #   it "should deduct the balance by the amount given" do
  #     subject.top_up(50)
  #     expect{ subject.deduct(40) }.to change{ subject.balance }.by -40
  #   end
  # end

  describe "#touch_in" do
    it "should change the in_journey? status of the card to true" do
      subject.top_up(50)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it "should remember the entry_station upon touch_in" do 
      subject.top_up(50)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it "should raise an error if the balance is less than £1 when trying to touch_in" do
      expect { subject.touch_in(entry_station) }.to raise_error "Touch in failed: Insufficient balance for journey"
    end
  end

  describe "#touch_out" do
    it "should change the in_journey status of the card to false" do
      subject.top_up(50)
      subject.touch_in(entry_station)
      subject.touch_out
      expect( subject.in_journey? ).to eq false
    end
    it "should deduct the MINIMUM_BALANCE_FOR_JOURNEY when user touches out" do
      subject.top_up(50)
      subject.touch_in(entry_station)
      expect { subject.touch_out }.to change{ subject.balance }.by(- Oystercard::MINIMUM_BALANCE_FOR_JOURNEY)
    end
    it "should set the entry_station variable to nil upon touch_out" do
      subject.top_up(50)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end

  describe "#in_journey?" do
    it "should return false when entry_station is equal to nil" do 
      subject.top_up(50)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end

end