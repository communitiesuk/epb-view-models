require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::CepcWrapper do
  context "when calling the CS63 wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "CS63-S-7.0", type: "action_plan", method_called: :to_hash },
        { schema: "CS63-S-7.0", type: "action_plan", method_called: :to_certificate_summary },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end
  end
end
