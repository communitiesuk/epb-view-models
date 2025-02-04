# frozen_string_literal: true

RSpec.describe ViewModel::Factory do
  context "it constructs an object from commercial xml" do
    it "constructs a CEPC object for CEPC-8.0.0 xml" do
      xml_doc = Nokogiri.XML(Samples.xml("CEPC-8.0.0", "cepc"))
      factory = described_class.new
      result = factory.create(xml_doc.to_xml, "CEPC-8.0.0")
      expect(result).to be_kind_of(ViewModel::CepcWrapper)
    end

    it "can filter an xml document with multiple reports" do
      xml_doc = Nokogiri.XML(Samples.xml("CEPC-8.0.0", "cepc+rr"))
      factory = described_class.new

      cepc_rr =
        factory.create(xml_doc.to_xml, "CEPC-8.0.0", "0000-0000-0000-0000-0001")
      expect(cepc_rr.to_hash[:assessment_id]).to eq("0000-0000-0000-0000-0001")
      expect(cepc_rr.to_hash[:type_of_assessment]).to eq("CEPC-RR")

      cepc =
        factory.create(xml_doc.to_xml, "CEPC-8.0.0", "0000-0000-0000-0000-0000")
      expect(cepc.to_hash[:assessment_id]).to eq("0000-0000-0000-0000-0000")
      expect(cepc.to_hash[:type_of_assessment]).to eq("CEPC")
    end
  end

  context "it constructs an object from domestic xml" do
    it "constructs a SAP object for SAP-Schema-19.1.0 xml" do
      xml_doc = Nokogiri.XML(Samples.xml("SAP-Schema-19.1.0", "epc"))
      factory = described_class.new
      result = factory.create(xml_doc.to_xml, "SAP-Schema-19.1.0")
      expect(result).to be_kind_of(ViewModel::SapWrapper)
    end

    it "can filter a domestic xml document with to_certificate_summary" do
      xml_doc = Nokogiri.XML(Samples.xml("SAP-Schema-19.1.0", "epc"))
      factory = described_class.new

      sap =
        factory.create(xml_doc.to_xml, "SAP-Schema-19.1.0", "0000-0000-0000-0000-0000")
      expect(sap.to_certificate_summary[:assessment_id]).to eq("0000-0000-0000-0000-0000")
      expect(sap.to_certificate_summary[:type_of_assessment]).to eq("SAP")
    end
  end
end
