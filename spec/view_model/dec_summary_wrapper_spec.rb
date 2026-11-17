require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::DecSummaryWrapper do
  context "when calling the DEC-SUMMARY wrapper for a valid schema" do
    it "returns the expected assertion for the to_xml method", :aggregate_failures do
      schema_tests = [
        { schema: "CEPC-8.0.0", type: "dec", method_called: :to_xml },
        { schema: "CEPC-NI-8.0.0", type: "dec", method_called: :to_xml },
        { schema: "CEPC-7.1", type: "dec", method_called: :to_xml },
        { schema: "CEPC-7.0", type: "dec", method_called: :to_xml },
        { schema: "CEPC-6.0", type: "dec", method_called: :to_xml },
        { schema: "DECAR-S-8.0.0", type: "dec", method_called: :to_xml },
        { schema: "DECAR-S-7.0", type: "dec", method_called: :to_xml },
      ]

      schema_tests.each do |schema|
        expect { test_xml_wrapper(schema) }.not_to raise_error
      end
    end
  end

  it "returns the expect view_model_boundary without a valid schema type" do
    expect { described_class.new("<xml/>", "invalid") }.to raise_error(
      ViewModel::DecSummaryWrapper::AssessmentNotSupported,
    )
  end
end
