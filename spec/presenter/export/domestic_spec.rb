require_relative "export_test_helper"

RSpec.describe Presenter::Export::Domestic do
  context "when building a domestic SAP export" do
    subject(:export) do
      schema_type = "SAP-Schema-18.0.0".freeze
      xml = Nokogiri.XML Samples.xml(schema_type)
      wrapper = ViewModel::Factory.new.create(xml.to_s, schema_type)
      described_class.new(wrapper, assessment)
    end

    let(:assessment) do
      assessment = double
      allow(assessment).to receive(:get).with(:address_id).and_return("RRN-0000-0000-0000-0000-0000")
      allow(assessment).to receive(:get).with(:created_at).and_return("2021-05-10T16:45:00+00:00")
      allow(assessment).to receive(:get).with(:cancelled_at).and_return(nil)
      allow(assessment).to receive(:get).with(:not_for_issue_at).and_return(nil)
      allow(assessment).to receive(:get).with(:opt_out).and_return(false)
      assessment
    end
    let(:expected) { read_json_fixture("sap") }

    it "matches the expected JSON" do
      expect(export.build).to eq(expected)
    end
  end

  context "when building a domestic RdSAP export" do
    subject(:export) do
      schema_type = "RdSAP-Schema-20.0.0".freeze
      xml = Nokogiri.XML Samples.xml(schema_type)
      wrapper = ViewModel::Factory.new.create(xml.to_s, schema_type)
      described_class.new(wrapper, assessment)
    end

    let(:assessment) do
      assessment = double
      allow(assessment).to receive(:get).with(:address_id).and_return("RRN-0000-0000-0000-0000-0000")
      allow(assessment).to receive(:get).with(:created_at).and_return("2021-05-10T16:45:00+00:00")
      allow(assessment).to receive(:get).with(:cancelled_at).and_return(nil)
      allow(assessment).to receive(:get).with(:not_for_issue_at).and_return(nil)
      allow(assessment).to receive(:get).with(:opt_out).and_return(false)
      assessment
    end
    let(:expected) { read_json_fixture("rdsap") }

    it "matches the expected JSON" do
      expect(export.build).to eq(expected)
    end
  end
end
