RSpec.describe Helper::ToBool do
  describe "to bool helper" do
    describe "true value" do
      it "returns true" do
        expect(
          described_class.execute("true"),
        ).to be true
      end

      it "returns false" do
        expect(
          described_class.execute("false"),
        ).to be false
      end

      it "raises an error" do
        expect(
          described_class.execute("hello"),
        ).to be_nil
      end
    end
  end
end
