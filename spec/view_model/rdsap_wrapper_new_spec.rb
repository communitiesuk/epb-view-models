require_relative "../wrapper_test_helper"

RSpec.describe ViewModel::RdSapWrapper do
  context "when calling the RdSAP wrapper for a valid schema" do
    it "returns the expected assertion" do
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
      ]

      schema_tests.each do |schema|
        test_wrapper(schema)
      end
    end
  end
end
