RSpec.describe Presenter::Xsd do
  let(:export) { described_class.new }

  context "when reading data from a specific xsd for processing" do
    let(:enums) { export.get_enums_by_type(simple_type: "SAP-BuiltFormCode", assessment_type: "SAP", xsd_dir_path: "/api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/") }

    it "extracts a hash of the enums for a particular node" do
      built_form = { "1" => "Detached",
                     "2" => "Semi-Detached",
                     "3" => "End-Terrace",
                     "4" => "Mid-Terrace",
                     "5" => "Enclosed End-Terrace",
                     "6" => "Enclosed Mid-Terrace" }
      expect(enums["SAP-Schema-18.0.0/SAP"]).to eq(built_form)
    end

    it "raises an boundary when a node is not defined in the xsd files" do
      expect {
        export.get_enums_by_type(
          simple_type: "UnicornCode",
          assessment_type: "SAP",
          xsd_dir_path: "/api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/",
        )
      }.to raise_error(
        Boundary::NodeNotFound,
        "Node UnicornCode was not found in any of the xsd files in /api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/ directory",
      )
    end
  end

  context "when traversing all the xsd for RdSAP type " do
    let(:enums) { export.get_enums_by_type(simple_type: "SAP-BuiltFormCode", assessment_type: "RdSAP", xsd_dir_path: "/api/schemas/xml/RdSAP**/RdSAP/UDT/") }

    describe "#get_enums_by_type" do
      it "raises an errors for an incorrect path" do
        expect { export.get_enums_by_type(simple_type: "TransactionType", assessment_type: "RdSAP", xsd_dir_path: "/api/schemas/xml/*/") }.to raise_error(Boundary::XsdFilesNotFound)
      end

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

    describe "#unique_enums" do
      it "returns and array of unique enum hashes" do
        built_form = [{ "1" => "Detached",
                        "2" => "Semi-Detached",
                        "3" => "End-Terrace",
                        "4" => "Mid-Terrace",
                        "5" => "Enclosed End-Terrace",
                        "6" => "Enclosed Mid-Terrace",
                        "NR" => "Not Recorded" }]
        expect(export.unique_enums(simple_type: "SAP-BuiltFormCode", assessment_type: "RdSAP", xsd_dir_path: "/api/schemas/xml/RdSAP**/RdSAP/UDT/")).to eq(built_form)
      end
    end

    describe "#variation_between_schema_versions?" do
      it "returns false if there are no variations between schema versions" do
        enums_hash =
          { "RdSAP-Schema-NI-19.0" => { "1" => "Detached",
                                        "2" => "Semi-Detached",
                                        "3" => "End-Terrace",
                                        "4" => "Mid-Terrace",
                                        "5" => "Enclosed End-Terrace",
                                        "6" => "Enclosed Mid-Terrace",
                                        "NR" => "Not Recorded" },
            "RdSAP-Schema-NI-20.0.0" => { "1" => "Detached",
                                          "2" => "Semi-Detached",
                                          "3" => "End-Terrace",
                                          "4" => "Mid-Terrace",
                                          "5" => "Enclosed End-Terrace",
                                          "6" => "Enclosed Mid-Terrace",
                                          "NR" => "Not Recorded" } }

        expect(export.variation_between_schema_versions?(enums_hash)).to eq(false)
      end

      it "returns true if there are variations between schema versions" do
        enums_hash =
          { "RdSAP-Schema-NI-19.0" => { "1" => "Detached",
                                        "2" => "Semi-Detached",
                                        "3" => "End-Terrace",
                                        "4" => "Mid-Terrace",
                                        "5" => "Enclosed End-Terrace",
                                        "6" => "Enclosed Mid-Terrace" },
            "RdSAP-Schema-NI-20.0.0" => { "1" => "Detached",
                                          "2" => "Semi-Detached",
                                          "3" => "End-Terrace",
                                          "4" => "Mid-Terrace",
                                          "5" => "Enclosed End-Terrace",
                                          "6" => "Enclosed Mid-Terrace",
                                          "NR" => "Not Recorded" } }

        expect(export.variation_between_schema_versions?(enums_hash)).to eq(true)
      end
    end
  end

  context "when traversing all the xsd for CEPC type" do
    let(:enums) { export.get_enums_by_type(simple_type: "TransactionType", assessment_type: "CEPC", xsd_dir_path: "/api/schemas/xml/CEPC-8.0.0/Reports/") }

    describe "#get_enums_by_type" do
      it "extracts a hash of the enums for a CEPC-8.0.0" do
        transation_types = {
          "1" => "Mandatory issue (Marketed sale).",
          "2" => "Mandatory issue (Non-marketed sale).",
          "3" => "Mandatory issue (Property on construction).",
          "4" => "Mandatory issue (Property to let).",
          "5" => "Voluntary re-issue (A valid EPC is already lodged).",
          "6" => "Voluntary (No legal requirement for an EPC).",
          "7" => "Not recorded.",
        }
        expect(enums["CEPC-8.0.0"]).to eq(transation_types)
      end
    end
  end
end
