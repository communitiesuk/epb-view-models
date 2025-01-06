require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::RdSapWrapper do
  context "when calling the RdSAP wrapper for a valid schema" do
    it "returns the expected assertion" do
      schema_tests = [
        { schema: "RdSAP-Schema-21.0.0", type: "epc", method_called: :to_hash }
      ]

      schema_tests.each do |schema|
        test_wrapper(schema)
      end
    end
  end
end
