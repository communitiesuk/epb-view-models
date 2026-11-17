require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::SapWrapper do
  context "when calling the sap wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "SAP-Schema-19.2.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-19.0.0", type: "epc_no_fixed_lights", method_called: :to_hash },
        { schema: "SAP-Schema-18.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-17.1", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-17.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-16.3", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-16.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-16.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-16.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-15.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-14.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-14.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-14.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-13.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-12.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-11.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-11.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-18.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.4", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.3", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-16.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-16.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-15.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.1", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-13.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-12.0", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-11.2", type: "sap", method_called: :to_hash },
        { schema: "SAP-Schema-S-20.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-S-19.0.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-S-17.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-S-16.1", type: "epc", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_create_summary method", :aggregate_failures do
      schema_tests = [
        { schema: "SAP-Schema-19.2.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-18.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-17.1", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-17.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.3", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.2", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.1", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-15.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-14.2", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-14.1", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-14.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-13.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-12.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-11.2", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-11.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-18.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.4", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.3", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.2", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.1", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-16.1", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-16.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-15.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-14.2", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-14.1", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-14.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-13.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-12.0", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-11.2", type: "sap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-S-20.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-S-19.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-S-17.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-S-16.1", type: "epc", method_called: :to_certificate_summary },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_hash_ni method", :aggregate_failures do
      schema_tests = [
        { schema: "SAP-Schema-NI-18.0.0", type: "epc", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.4", type: "epc", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.3", type: "epc", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.2", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.1", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.0", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-16.1", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-16.0", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-15.0", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-14.2", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-14.1", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-14.0", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-13.0", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-12.0", type: "sap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-11.2", type: "sap", method_called: :to_hash_ni },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_report method", :aggregate_failures do
      schema_tests = [
        { schema: "SAP-Schema-19.2.0", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-18.0.0", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-17.1", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-17.0", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-16.3", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-16.2", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-16.1", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-16.0", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-15.0", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-14.2", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-14.1", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-14.0", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-13.0", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-12.0", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-11.2", type: "sap", method_called: :to_report },
        { schema: "SAP-Schema-11.0", type: "sap", method_called: :to_report },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_domestic_digest method", :aggregate_failures do
      schema_tests = [
        { schema: "SAP-Schema-19.2.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-18.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-17.1", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-17.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.3", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.2", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.1", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-15.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-14.2", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-14.1", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-14.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-13.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-12.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-11.2", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-11.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-18.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.4", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.3", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.2", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.1", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-16.1", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-16.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-15.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-14.2", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-14.1", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-14.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-13.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-12.0", type: "sap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-11.2", type: "sap", method_called: :to_domestic_digest },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_recommendation_report method", :aggregate_failures do
      schema_tests = [
        { schema: "SAP-Schema-NI-18.0.0", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-NI-17.4", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-NI-17.3", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-18.0.0", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-17.1", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-17.0", type: "epc", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-16.3", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-16.2", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-16.1", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-16.0", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-15.0", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-14.1", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-14.0", type: "sap", method_called: :to_recommendation_report },
        { schema: "SAP-Schema-13.0", type: "sap", method_called: :to_recommendation_report },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "raises an error for an invalid schema type" do
      expect { described_class.new "", "invalid" }.to raise_error ArgumentError, "Unsupported schema type"
    end

    it "raises an error when a HCR report is requested for an unsupported schema" do
      expect { described_class.new "", :"SAP-Schema-16.3", "1" }.to raise_error ArgumentError, "Unsupported schema type"
      expect { described_class.new "", :"SAP-Schema-16.2", "1" }.to raise_error ArgumentError, "Unsupported schema type"
      expect { described_class.new "", :"SAP-Schema-16.1", "1" }.to raise_error ArgumentError, "Unsupported schema type"
    end

    it "gives a deprecation warning when calling the deprecated to_hera_hash method" do
      sample = Samples.xml("SAP-Schema-19.2.0", "epc")
      view_model = ViewModel::Factory.new.create(sample, "SAP-Schema-19.2.0", nil)

      expect { view_model.to_hera_hash }.to output(/deprecated/).to_stderr
    end
  end
end
