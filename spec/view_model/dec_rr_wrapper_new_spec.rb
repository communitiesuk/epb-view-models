require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::DecRrWrapper do
  context "when calling the DEC-RR wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "CEPC-8.0.0", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-8.0.0", type: "dec-rr-large-building", method_called: :to_hash },
        { schema: "CEPC-NI-8.0.0", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "dec-rr-ni", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "dec-rr-ni", method_called: :to_hash },
        { schema: "CEPC-6.0", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-6.0", type: "dec-rr-ni", method_called: :to_hash },
        { schema: "CEPC-5.1", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-5.1", type: "dec-rr-ni", method_called: :to_hash },
        { schema: "CEPC-5.0", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-5.0", type: "dec-rr-ni", method_called: :to_hash },
        { schema: "CEPC-4.0", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-4.0", type: "dec-rr-ni", method_called: :to_hash },
        { schema: "CEPC-3.1", type: "dec-rr", method_called: :to_hash },
        { schema: "CEPC-3.1", type: "dec-rr-ni", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end
  end
end
