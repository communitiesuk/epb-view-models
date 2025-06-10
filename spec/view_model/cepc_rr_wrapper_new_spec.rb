require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::CepcRrWrapper do
  context "when calling the CEPC-RR wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "CEPC-8.0.0", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-NI-8.0.0", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-6.0", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-5.1", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-5.0", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-4.0", type: "cepc-rr", method_called: :to_hash },
        { schema: "CEPC-3.1", type: "cepc-rr", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_report method", :aggregate_failures do
      schema_tests = [
        { schema: "CEPC-NI-8.0.0", type: "cepc-rr", method_called: :to_report },
        { schema: "CEPC-7.1", type: "cepc-rr-ni", method_called: :to_report },
        { schema: "CEPC-7.0", type: "cepc-rr-ni", method_called: :to_report },
        { schema: "CEPC-6.0", type: "cepc-rr-ni", method_called: :to_report },
        { schema: "CEPC-5.1", type: "cepc-rr-ni", method_called: :to_report },
        { schema: "CEPC-5.0", type: "cepc-rr-ni", method_called: :to_report },
        { schema: "CEPC-4.0", type: "cepc-rr-ni", method_called: :to_report },
        { schema: "CEPC-3.1", type: "cepc-rr-ni", method_called: :to_report },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end
  end
end
