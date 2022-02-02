require_relative '../lib/station'

describe Station do

  subject { described_class.new("Waterloo", 1) }

  it "saves the name it's given" do 
    expect(subject.name).to eq("Waterloo")
  end

  it "saves the zone it's given" do 
    expect(subject.zone).to eq(1)
  end
  
end