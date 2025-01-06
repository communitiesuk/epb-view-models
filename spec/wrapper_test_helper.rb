def test_wrapper(schema_case)
  schema_case[:type] = "epc" unless schema_case[:type]

  sample = Samples.xml(schema_case[:schema], schema_case[:type])

  validate_xml(sample, schema_case)

  view_model = ViewModel::Factory.new.create(sample, schema_case[:schema], nil)

  source_hash = view_model.method(schema_case[:method_called]).call
  # print source_hash.to_json
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
  assertion_path = if type == "epc"
                     File.join Dir.pwd, "spec/fixtures/assertions/#{assertion}/#{method_called}.json"
                   else
                     File.join Dir.pwd, "spec/fixtures/assertions/#{assertion}/#{method_called}_#{type}.json"
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
