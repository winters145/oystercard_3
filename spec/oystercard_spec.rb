require_relative '../lib/oystercard.rb'

describe Oystercard do
  describe "#top_up" do  
    it "should add money to the oyster card" do
      oystercard = Oystercard.new
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
  end
end



# Notes on Stack Trace:
# NameError - unitialized constant Oystercard
# ./spec/oystercard_spec
# rb:1:in