require_relative '../lib/oystercard.rb'

describe Oystercard do
  describe "#balance"
  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end
  
  describe "#top_up" do
  it "balance of card should increase by given value" do
    # subject.top_up(10)
    # expect(subject.balance).to eq(10)
    expect{ subject.top_up 10 }.to change{ subject.balance }.by 10 
    # expect { a += 1 }.to change { a }.by(1)
    end
  end
end

  




#   describe "#top_up" do  
#     it "should add money to the oyster card" do
#       oystercard = Oystercard.new
#       expect(oystercard).to respond_to(:top_up).with(1).argument
#     end
#   end
# end



# Notes on Stack Trace:
# NameError - unitialized constant Oystercard
# ./spec/oystercard_spec
# rb:1:in