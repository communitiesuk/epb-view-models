RSpec.describe Gateway::XsdFilesGateway do
  subject(:gateway) { described_class.new(simple_type: "SomeNodeName", assessment_type: "RdSAP") }

  it "initializes with simple_type, assessment_type and xsd_dir_path" do
    expect(gateway.simple_type).to eq("SomeNodeName")
    expect(gateway.assessment_type).to eq("RdSAP")
    expect(gateway.xsd_dir_path).to eq("api/schemas/xml/*/")
  end

  describe "#xsd_files" do
    it "raises an boundary when it cannot find a path" do
      gateway = described_class.new(xsd_dir_path: "path/that/doesnt/exist", simple_type: "SomeNodeName", assessment_type: "SAP")

      expect { gateway.xsd_files }.to raise_error(
                                        Boundary::XsdFilesNotFound,
        "No xsd files were found in path/that/doesnt/exist directory",
      )
    end
  end

  describe "#schema_version" do
    it "retruns schema version for a file" do
      file = "api/schemas/xml/CEPC-8.0.0/Reports/Reported-Data.xsd"

      expect(gateway.schema_version(file)).to eq("CEPC-8.0.0")
    end

    it "appends with /SAP if the SAP definition is in the RdSAP directory" do
      gateway = described_class.new(simple_type: "SomeNodeName", assessment_type: "SAP")
      file = "api/schemas/xml/RdSAP-Schema-17.1/RdSAP/UDT/SAP-Domains.xsd"

      expect(gateway.schema_version(file)).to eq("RdSAP-Schema-17.1/SAP")
    end
  end
end
