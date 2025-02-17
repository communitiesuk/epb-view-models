require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::AcCertWrapper do
  context "when calling the AC-CERT wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "CEPC-8.0.0", type: "ac-cert", method_called: :to_hash },
        { schema: "CEPC-NI-8.0.0", type: "ac-cert", method_called: :to_hash },
        { schema: "CEPC-7.1", type: "ac-cert", method_called: :to_hash },
        { schema: "CEPC-7.0", type: "ac-cert", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end
  end
end
