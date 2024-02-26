RSpec.describe Helper::ToBool do
  describe "to bool helper" do
    describe "true value" do
      it "returns true" do
        expect(
          described_class.execute("true"),
        ).to eq true
      end

      it "returns false" do
        expect(
          described_class.execute("false"),
        ).to eq false
      end

      it "raises an error" do
        expect(
          described_class.execute("hello"),
        ).to eq nil
      end
    end
  end
end
