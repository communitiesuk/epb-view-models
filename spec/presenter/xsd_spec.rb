RSpec.describe Presenter::Xsd do
  context "when reading data from a specific xsd for processing" do
    let(:export) { described_class.new(assessment_type: "SAP", xsd_dir_path: "api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/") }

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
      expect(enums["SAP-Schema-18.0.0/SAP"]).to eq(built_form)
    end
  end

  context "when traversing all the xsd for RdSAP type " do
    let(:export) { described_class.new(assessment_type: "RdSAP", xsd_dir_path: "api/schemas/xml/RdSAP**/RdSAP/UDT/") }

    let(:enums) { export.get_enums_by_type("SAP-BuiltFormCode") }

    describe "#get_enums_by_type" do
      it "extracts a hash of the enums for a Rdsap 17 node" do
        built_form = { "1" => "Detached",
                       "2" => "Semi-Detached",
                       "3" => "End-Terrace",
                       "4" => "Mid-Terrace",
                       "5" => "Enclosed End-Terrace",
                       "6" => "Enclosed Mid-Terrace",
                       "NR" => "Not Recorded" }
        expect(enums["RdSAP-Schema-17.0"]).to eq(built_form)
      end

      it "extracts a hash of the enums for a Rdsap 18 node" do
        built_form = { "1" => "Detached",
                       "2" => "Semi-Detached",
                       "3" => "End-Terrace",
                       "4" => "Mid-Terrace",
                       "5" => "Enclosed End-Terrace",
                       "6" => "Enclosed Mid-Terrace",
                       "NR" => "Not Recorded" }
        expect(enums["RdSAP-Schema-18.0"]).to eq(built_form)
      end
    end

    end
  end
end
