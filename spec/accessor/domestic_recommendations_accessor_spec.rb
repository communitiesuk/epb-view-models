RSpec.describe Accessor::DomesticRecommendationsAccessor do
  subject(:accessor) { described_class.instance }

  after do
    accessor.reset!
  end

  context "when creating a entry for a domestic recommendation" do
    it "returns the appropriate text for summary and description" do
      response = accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "5")
      expect(response.summary).to eq "Increase loft insulation to 270 mm"
      expect(response.description).to eq "Increase loft insulation to 270 mm"
    end
  end

  context "when creating a entry for a domestic recommendation NI" do
    it "returns the appropriate text for summary and description" do
      response = accessor.fetch_details(schema_version: "RdSAP-Schema-NI-20.0.0", improvement_number: "5")
      expect(response.summary).to eq "Increase loft insulation to 270 mm"
      expect(response.description).to eq "Loft insulation laid in the loft space or between roof rafters to a depth of at least 270 mm will significantly reduce heat loss through the roof; this will improve levels of comfort, reduce energy use and lower fuel bills. Insulation should not be placed below any cold water storage tank; any such tank should also be insulated on its sides and top, and there should be boarding on battens over the insulation to provide safe access between the loft hatch and the cold water tank. The insulation can be installed by professional contractors but also by a capable DIY enthusiast. Loose granules may be used instead of insulation quilt; this form of loft insulation can be blown into place and can be useful where access is difficult. The loft space must have adequate ventilation to prevent dampness; seek advice about this if unsure (particularly if installing insulation between rafters because a vapour control layer and ventilation above the insulation are required). Further information about loft insulation and details of local contractors can be obtained from the National Insulation Association (www.nationalinsulationassociation.org.uk)."
    end
  end

  context "when fetching two recommendations for the same schema" do
    it "only calls nokogiri once" do
      expect(Nokogiri).to receive(:XML).once.and_call_original
      accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "5")
      accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "1")
    end
  end

  context "when fetching two recommendations for different schema" do
    it "calls nokogiri twice" do
      expect(Nokogiri).to receive(:XML).twice.and_call_original
      accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "5")
      accessor.fetch_details(schema_version: "RdSAP-Schema-19.0", improvement_number: "1")
    end
  end

  context "when fetching three recommendations for different schema" do
    it "calls nokogiri thrice" do
      expect(Nokogiri).to receive(:XML).thrice.and_call_original
      accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "5")
      accessor.fetch_details(schema_version: "RdSAP-Schema-19.0", improvement_number: "1")
      accessor.fetch_details(schema_version: "SAP-Schema-19.0.0", improvement_number: "19")
    end
  end

  context "when fetching three recommendations for one schema the same but two different" do
    it "calls nokogiri twice" do
      expect(Nokogiri).to receive(:XML).twice.and_call_original
      accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "5")
      accessor.fetch_details(schema_version: "RdSAP-Schema-19.0", improvement_number: "1")
      accessor.fetch_details(schema_version: "RdSAP-Schema-20.0.0", improvement_number: "19")
    end
  end
end
