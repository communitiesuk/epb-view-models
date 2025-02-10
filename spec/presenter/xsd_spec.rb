RSpec.describe Presenter::Xsd do
  let(:export) { described_class.new }

  context "when reading data from a specific xsd for processing" do
    let(:enums) do
      export.get_enums_by_type(ViewModelDomain::XsdArguments.new(simple_type: "SAP-BuiltFormCode",
                                                                 assessment_type: "SAP", xsd_dir_path: "/api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/*-Domains.xsd"))
    end

    it "extracts a hash of the enums for a particular node" do
      built_form = { "1" => "Detached",
                     "2" => "Semi-Detached",
                     "3" => "End-Terrace",
                     "4" => "Mid-Terrace",
                     "5" => "Enclosed End-Terrace",
                     "6" => "Enclosed Mid-Terrace" }
      expect(enums["SAP-Schema-18.0.0/SAP"]).to eq(built_form)
    end

    it "raises an view_model_boundary when a node is not defined in the xsd files" do
      expect {
        export.get_enums_by_type(
          ViewModelDomain::XsdArguments.new(
            simple_type: "UnicornCode",
            assessment_type: "SAP",
            xsd_dir_path: "/api/schemas/xml/SAP-Schema-18.0.0/SAP/UDT/*-Domains.xsd",
          ),
        )
      }.to raise_error(
        ViewModelBoundary::NodeNotFound,
        /Node UnicornCode was not found in any of the files in /,
      )
    end
  end

  context "when traversing all the xsd for RdSAP type" do
    let(:enums) { export.get_enums_by_type(ViewModelDomain::XsdArguments.new(simple_type: "SAP-BuiltFormCode", assessment_type: "RdSAP", xsd_dir_path: "/api/schemas/xml/RdSAP**/RdSAP/UDT/*-Domains.xsd")) }

    describe "#get_enums_by_type" do
      it "raises an errors for an incorrect path" do
        expect { export.get_enums_by_type(ViewModelDomain::XsdArguments.new(simple_type: "TransactionType", assessment_type: "RdSAP", xsd_dir_path: "/test/schemas/xml/*/")) }.to raise_error(ViewModelBoundary::XsdFilesNotFound)
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
        expect(export.unique_enums(ViewModelDomain::XsdArguments.new(simple_type: "SAP-BuiltFormCode", assessment_type: "RdSAP", xsd_dir_path: "/api/schemas/xml/RdSAP**/RdSAP/UDT/*-Domains.xsd"))).to eq(built_form)
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
    let(:enums) { export.get_enums_by_type(ViewModelDomain::XsdArguments.new(simple_type: "TransactionType", assessment_type: "CEPC", xsd_dir_path: "/api/schemas/xml/CEPC-8.0.0/Reports/Reported-Data.xsd")) }

    describe "#get_enums_by_type" do
      it "extracts a hash of the enums for a CEPC-8.0.0" do
        transaction_types = {
          "1" => "Mandatory issue (Marketed sale).",
          "2" => "Mandatory issue (Non-marketed sale).",
          "3" => "Mandatory issue (Property on construction).",
          "4" => "Mandatory issue (Property to let).",
          "5" => "Voluntary re-issue (A valid EPC is already lodged).",
          "6" => "Voluntary (No legal requirement for an EPC).",
          "7" => "Not recorded.",
        }
        expect(enums["CEPC-8.0.0"]).to eq(transaction_types)
      end
    end
  end

  context "when the enum is stored in XML rather than an xsd" do
    let(:enums) do
      export.get_enums_by_type(ViewModelDomain::XsdArguments.new(simple_type: "//Transaction-Type", assessment_type: "RdSAP",
                                                                 xsd_dir_path: "/api/schemas/xml/RdSAP-Schema-20.0.0/RdSAP/ExternalDefinitions.xml",
                                                                 node_hash: { "Transaction-Code" => "Transaction-Text" }))
    end

    let(:sorted_enums) do
      enums["RdSAP-Schema-20.0.0"].sort_by { |k, _v| k.to_i }.to_h
    end

    it "extract the values for using nokogiri for transaction type in RdSAP" do
      transaction_types = {
        "1" => "Marketed sale",
        "2" => "Non-marketed sale",
        "5" => "None of the above",
        "6" => "New dwelling",
        "8" => "Rental",
        "9" => "Assessment for Green Deal",
        "10" => "Following Green Deal",
        "11" => "FiT application",
        "12" => "RHI application",
        "13" => "ECO assessment",
        "14" => "Stock condition survey",
      }

      expect(sorted_enums).to eq(transaction_types)
    end
  end
end
