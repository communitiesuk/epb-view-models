# require_relative "export_test_helper"

RSpec.describe Presenter::Export::Statistics do
  context "when building a domestic SAP statistics export" do
    subject(:stats_export) do
      schema_type = "SAP-Schema-18.0.0"
      xml = Nokogiri.XML Samples.xml(schema_type)
      wrapper = ViewModel::Factory.new.create(xml.to_s, schema_type)
      described_class.new(wrapper)
    end

    it "returns a hash with relevant keys" do
      expect(stats_export.build).to eq({
        current_energy_rating: 50,
        transaction_type: "1",
      })
    end
  end

  context "when building a domestic RdSAP statistics export" do
    subject(:stats_export) do
      schema_type = "RdSAP-Schema-20.0.0"
      xml = Nokogiri.XML Samples.xml(schema_type)
      wrapper = ViewModel::Factory.new.create(xml.to_s, schema_type)
      described_class.new(wrapper)
    end

    it "returns a hash with relevant keys" do
      expect(stats_export.build).to eq({
        current_energy_rating: 50,
        transaction_type: "1",
      })
    end
  end

  context "when building a Commercial EPC export" do
    subject(:stats_export) do
      schema_type = "CEPC-8.0.0".freeze
      xml = Nokogiri.XML Samples.xml(schema_type, "cepc")
      wrapper = ViewModel::Factory.new.create(xml.to_s, schema_type)
      described_class.new(wrapper)
    end

    it "returns a hash with relevant keys" do
      expect(stats_export.build).to eq({
        current_energy_rating: "80",
        transaction_type: "1",
      })
    end
  end
end
