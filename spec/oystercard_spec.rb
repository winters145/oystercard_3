require_relative '../lib/oystercard.rb'

describe Oystercard do
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
end

# Notes on Stack Trace:
# NameError - unitialized constant Oystercard
# ./spec/oystercard_spec
# rb:1:in