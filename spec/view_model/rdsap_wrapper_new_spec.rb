require_relative "../wrapper_test_helper"

# rubocop:disable RSpec/SpecFilePathFormat
RSpec.describe ViewModel::RdSapWrapper do
  context "when calling the RdSAP wrapper for a valid schema" do
    it "returns the expected assertion for the to_hash method", :aggregate_failures do
      schema_tests = [
        { schema: "RdSAP-Schema-21.0.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-20.0.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-19.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-18.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-17.1", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-17.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-16.3", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-16.2", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-16.1", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-16.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-15.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-14.2", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-14.1", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-14.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-13.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-12.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-11.2", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-11.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-10.2", type: "rdsap", method_called: :to_hash },
        { schema: "RdSAP-Schema-NI-21.0.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-NI-20.0.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-NI-19.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-NI-18.0", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-NI-17.4", type: "epc", method_called: :to_hash },
        { schema: "RdSAP-Schema-NI-17.3", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.2", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.1", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-17.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-16.1", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-16.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-15.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.2", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.1", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-14.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-13.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-12.0", type: "rdsap", method_called: :to_hash },
        { schema: "SAP-Schema-NI-11.2", type: "rdsap", method_called: :to_hash },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_certificate_summary method", :aggregate_failures do
      schema_tests = [
        { schema: "RdSAP-Schema-21.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-20.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-19.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-18.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-17.1", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-17.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.3", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.2", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.1", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-16.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-15.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-14.2", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-14.1", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-14.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-13.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-12.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-11.2", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-11.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-10.2", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-NI-21.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-NI-20.0.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-NI-19.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-NI-18.0", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-NI-17.4", type: "epc", method_called: :to_certificate_summary },
        { schema: "RdSAP-Schema-NI-17.3", type: "epc", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.2", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.1", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-17.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-16.1", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-16.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-15.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-14.2", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-14.1", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-14.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-13.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-12.0", type: "rdsap", method_called: :to_certificate_summary },
        { schema: "SAP-Schema-NI-11.2", type: "rdsap", method_called: :to_certificate_summary },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_hash_ni method", :aggregate_failures do
      schema_tests = [
        { schema: "RdSAP-Schema-NI-21.0.0", type: "epc", method_called: :to_hash_ni },
        { schema: "RdSAP-Schema-NI-20.0.0", type: "epc", method_called: :to_hash_ni },
        { schema: "RdSAP-Schema-NI-19.0", type: "epc", method_called: :to_hash_ni },
        { schema: "RdSAP-Schema-NI-18.0", type: "epc", method_called: :to_hash_ni },
        { schema: "RdSAP-Schema-NI-17.4", type: "epc", method_called: :to_hash_ni },
        { schema: "RdSAP-Schema-NI-17.3", type: "epc", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.2", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.1", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-17.0", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-16.1", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-16.0", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-15.0", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-14.2", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-14.1", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-14.0", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-13.0", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-12.0", type: "rdsap", method_called: :to_hash_ni },
        { schema: "SAP-Schema-NI-11.2", type: "rdsap", method_called: :to_hash_ni },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_report method", :aggregate_failures do
      schema_tests = [
        { schema: "RdSAP-Schema-21.0.0", type: "epc", method_called: :to_report },
        { schema: "RdSAP-Schema-20.0.0", type: "epc", method_called: :to_report },
        { schema: "RdSAP-Schema-19.0", type: "epc", method_called: :to_report },
        { schema: "RdSAP-Schema-18.0", type: "epc", method_called: :to_report },
        { schema: "RdSAP-Schema-17.1", type: "epc", method_called: :to_report },
        { schema: "RdSAP-Schema-17.0", type: "epc", method_called: :to_report },
        { schema: "SAP-Schema-16.3", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-16.2", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-16.1", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-16.0", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-15.0", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-14.2", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-14.1", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-14.0", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-13.0", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-12.0", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-11.2", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-11.0", type: "rdsap", method_called: :to_report },
        { schema: "SAP-Schema-10.2", type: "rdsap", method_called: :to_report },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end

    it "returns the expected assertion for the to_domestic_digest method", :aggregate_failures do
      schema_tests = [
        { schema: "RdSAP-Schema-21.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-20.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-19.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-18.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-17.1", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-17.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.3", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.2", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.1", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-16.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-15.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-14.2", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-14.1", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-14.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-13.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-12.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-11.2", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-11.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-10.2", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-NI-21.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-NI-20.0.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-NI-19.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-NI-18.0", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-NI-17.4", type: "epc", method_called: :to_domestic_digest },
        { schema: "RdSAP-Schema-NI-17.3", type: "epc", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.2", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.1", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-17.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-16.1", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-16.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-15.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-14.2", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-14.1", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-14.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-13.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-12.0", type: "rdsap", method_called: :to_domestic_digest },
        { schema: "SAP-Schema-NI-11.2", type: "rdsap", method_called: :to_domestic_digest },
      ]

      schema_tests.each do |schema|
        expect { test_wrapper(schema) }.not_to raise_error
      end
    end
  end
end

# rubocop:enable RSpec/SpecFilePathFormat
