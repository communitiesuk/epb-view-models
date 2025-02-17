# frozen_string_literal: true

RSpec.describe "Helper::EnergyBandCalculator" do
  context "when calculating energy band for domestic property" do
    it "returns a band of G for a rating of 17" do
      expect(Helper::EnergyBandCalculator.domestic(17)).to eq "g"
    end

    it "returns nil for a nil rating" do
      expect(Helper::EnergyBandCalculator.domestic(nil)).to be_nil
    end
  end

  context "when calculating energy band for commercial property" do
    it "returns a band of A+ for a rating of -1" do
      expect(Helper::EnergyBandCalculator.commercial(-1)).to eq "a+"
    end

    it "returns a band of A for a rating of 0" do
      expect(Helper::EnergyBandCalculator.commercial(0)).to eq "a"
    end

    it "returns a band of B for a rating of 50" do
      expect(Helper::EnergyBandCalculator.commercial(50)).to eq "b"
    end

    it "returns nil for a nil rating" do
      expect(Helper::EnergyBandCalculator.commercial(nil)).to be_nil
    end
  end
end
