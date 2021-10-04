RSpec.describe Presenter::Xsd do
  context "when reading data from a specific xsd for processing" do
    let(:export) { described_class.new(xsd_dir_path: "api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/SAP-Domains.xsd") }

    # it "reads all xsd files from the API directory" do
    #   expect(export.read_files).to be_a(Array)
    #   expect(export.read_files).to include(match(/Domains.xsd/))
    # end
    let(:enums) { export.get_enums_by_type("SAP-BuiltFormCode") }

    it "extracts a hash of the enums for a particular node" do
      built_form = { "1" => "Detached",
                     "2" => "Semi-Detached",
                     "3" => "End-Terrace",
                     "4" => "Mid-Terrace",
                     "5" => "Enclosed End-Terrace",
                     "6" => "Enclosed Mid-Terrace" }
      expect(enums).to be_a(Array)
      expect(enums.length).to eq(1)
      expect(enums.first).to eq(built_form)
    end
  end
end
