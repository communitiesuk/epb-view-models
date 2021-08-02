RSpec.describe "ViewModel::Domestic::ConstructionAgeBand" do
  test_data =
    [
      { schema: "SAP-Schema-18.0.0", type: "epc", construction_option: "1750" },
      { schema: "SAP-Schema-17.1", type: "epc", construction_option: "1750" },
      { schema: "SAP-Schema-17.0", type: "epc", construction_option: "1750" },
      { schema: "SAP-Schema-16.3", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-16.3", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-16.2", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-16.2", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-16.1", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-16.1", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-16.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-16.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-15.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-15.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-14.2", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-14.2", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-14.1", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-14.1", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-14.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-14.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-13.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-13.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-12.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-12.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-11.2", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-11.2", type: "rdsap", construction_option: "C" },
      { schema: "SAP-Schema-11.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-11.0", type: "rdsap", construction_option: "C" },
      { schema: "SAP-Schema-10.2", type: "rdsap", construction_option: "C" },

      { schema: "SAP-Schema-NI-18.0.0", type: "epc", construction_option: "K" },
      { schema: "SAP-Schema-NI-17.4", type: "epc", construction_option: "K" },
      { schema: "SAP-Schema-NI-17.3", type: "epc", construction_option: "K" },
      { schema: "SAP-Schema-NI-17.2", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-17.2", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-17.1", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-17.1", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-17.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-17.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-16.1", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-16.1", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-16.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-16.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-15.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-15.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-14.2", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-14.2", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-14.1", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-14.1", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-14.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-14.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-13.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-13.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-12.0", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-12.0", type: "sap", construction_option: "1750" },
      { schema: "SAP-Schema-NI-11.2", type: "rdsap", construction_option: "A" },
      { schema: "SAP-Schema-NI-11.2", type: "sap", construction_option: "1750" },

      { schema: "RdSAP-Schema-20.0.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-19.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-18.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-17.1", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-17.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-NI-20.0.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-NI-19.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-NI-18.0", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-NI-17.4", type: "epc", construction_option: "K" },
      { schema: "RdSAP-Schema-NI-17.3", type: "epc", construction_option: "K" },
    ]

  test_data.each do |data|
    it "returns the value for construction age band or construction year for #{data[:schema]}" do
      document = Nokogiri.XML Samples.xml(data[:schema], data[:type])
      wrapper = ViewModel::Factory.new.create(document.to_s, data[:schema].to_s)
      age_band = wrapper.view_model.main_dwelling_construction_age_band_or_year

      expect(age_band).to eq(data[:construction_option])
    end
  end
end
