# require_relative "../xml_view_test_helper"
require "active_support/core_ext/hash/deep_merge"
require "json"

RSpec.describe ViewModel::SapWrapper do

  context "when calling the sap wrapper for a valid schema" do
    it "returns the expected assertion" do
      schema_tests = [
        { schema: "SAP-Schema-19.1.0", type: "epc", method_called: :to_hash },
        { schema: "SAP-Schema-19.0.0", type: "epc", method_called: :to_hash },
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
      ]

      schema_tests.each do |schema|
        test_wrapper(schema)
      end
    end
  end
end

def test_wrapper(schema_case)

  schema_case[:type] = "epc" unless schema_case[:type]

  sample = Samples.xml(schema_case[:schema], schema_case[:type])

  validate_xml(sample, schema_case)

  view_model = ViewModel::Factory.new.create(sample, schema_case[:schema], nil)

  source_hash = view_model.method(schema_case[:method_called]).call
  print source_hash.to_json
  assertion = fetch_assertion(schema_case[:schema], schema_case[:method_called], schema_case[:type])

  assertion.each do |key, value|
    result = source_hash[key]

    expect(result).to eq(value), <<~ERROR
      Failed on #{schema_case[:schema]}:#{schema_case[:type]}:#{key}
        EXPECTED: "#{value}" (#{value.class})
             GOT: "#{result}" (#{result.class})
    ERROR
  end

  expect(assertion.keys).to eq(source_hash.keys)
end

def validate_xml(sample, schema_case)
  schema_path = Helper::SchemaListHelper.new(schema_case[:schema]).schema_path

  schema =
    Nokogiri::XML::Schema.from_document Nokogiri.XML(
      File.read(schema_path),
      schema_path,
      )

  validation = schema.validate(Nokogiri.XML(sample))

  expect(validation).to be_empty, <<~ERROR
  Failed on #{schema_case[:schema]}:#{schema_case[:type]}
    This document does not validate against the chosen schema,
      Errors:
        #{validation.join("\n      ")}
  ERROR
end

def fetch_assertion(assertion, method_called, type)

  unless type == "epc"
    assertion_path = File.join Dir.pwd, "spec/fixtures/assertions/#{assertion}/#{method_called.to_s}_#{type}.json"
  else
    assertion_path = File.join Dir.pwd, "spec/fixtures/assertions/#{assertion}/#{method_called.to_s}.json"
  end

  unless File.exist? assertion_path
    raise ArgumentError,
          "No assertion found for schema #{schema}, create one at #{
            assertion_path
          }"
  end

  json_assertion = File.read assertion_path
  JSON.parse(json_assertion, symbolize_names: true)
end