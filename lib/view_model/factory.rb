# frozen_string_literal: true

module ViewModel
  class Factory
    TYPES_OF_CEPC = %i[
      CEPC-8.0.0
      CEPC-NI-8.0.0
      CEPC-7.1
      CEPC-7.0
      CEPC-6.0
      CEPC-5.1
      CEPC-5.0
      CEPC-4.0
      CEPC-3.1
      CEPC-S-7.1
    ].freeze
    TYPES_OF_RD_SAP = %i[
      RdSAP-Schema-21.0.0
      RdSAP-Schema-20.0.0
      RdSAP-Schema-19.0
      RdSAP-Schema-18.0
      RdSAP-Schema-17.1
      RdSAP-Schema-17.0
      RdSAP-Schema-NI-21.0.0
      RdSAP-Schema-NI-20.0.0
      RdSAP-Schema-NI-19.0
      RdSAP-Schema-NI-18.0
      RdSAP-Schema-NI-17.4
      RdSAP-Schema-NI-17.3
      RdSAP-Schema-S-19.0
    ].freeze
    TYPES_OF_SAP = %i[
      SAP-Schema-19.1.0
      SAP-Schema-19.0.0
      SAP-Schema-18.0.0
      SAP-Schema-17.1
      SAP-Schema-17.0
      SAP-Schema-16.3
      SAP-Schema-16.2
      SAP-Schema-16.1
      SAP-Schema-16.0
      SAP-Schema-15.0
      SAP-Schema-14.2
      SAP-Schema-14.1
      SAP-Schema-14.0
      SAP-Schema-13.0
      SAP-Schema-12.0
      SAP-Schema-11.2
      SAP-Schema-11.0
      SAP-Schema-10.2
      SAP-Schema-NI-18.0.0
      SAP-Schema-NI-17.4
      SAP-Schema-NI-17.3
      SAP-Schema-NI-17.2
      SAP-Schema-NI-17.1
      SAP-Schema-NI-17.0
      SAP-Schema-NI-16.1
      SAP-Schema-NI-16.0
      SAP-Schema-NI-15.0
      SAP-Schema-NI-14.2
      SAP-Schema-NI-14.1
      SAP-Schema-NI-14.0
      SAP-Schema-NI-13.0
      SAP-Schema-NI-12.0
      SAP-Schema-NI-11.2
      SAP-Schema-S-19.0.0
    ].freeze
    def create(xml, schema_type, filter_results_for = nil, additional_data = {})
      # Hack to use symbols, we need to update all callers to use symbols instead
      schema_type = schema_type.to_sym

      xml_doc = Nokogiri.XML(xml, nil, nil, Nokogiri::XML::ParseOptions.new.huge.strict).remove_namespaces!

      if TYPES_OF_CEPC.include?(schema_type)
        filtered_results =
          if filter_results_for
            xml_doc.at("//*[RRN=\"#{filter_results_for}\"]/ancestor::Report")
          else
            xml_doc
          end

        report_type = filtered_results.at("Report-Type").content

        case report_type
        when "1"
          ViewModel::DecWrapper.new(filtered_results, schema_type, additional_data)
        when "2"
          ViewModel::DecRrWrapper.new(filtered_results, schema_type)
        when "3"
          ViewModel::CepcWrapper.new(filtered_results, schema_type, additional_data)
        when "4"
          ViewModel::CepcRrWrapper.new(filtered_results, schema_type)
        when "5"
          ViewModel::AcReportWrapper.new(filtered_results, schema_type)
        when "6"
          ViewModel::AcCertWrapper.new(filtered_results, schema_type)
        else
          raise ArgumentError, "Invalid CEPC report type"
        end
      elsif TYPES_OF_RD_SAP.include?(schema_type)
        ViewModel::RdSapWrapper.new(xml_doc, schema_type, additional_data)
      elsif TYPES_OF_SAP.include?(schema_type)
        report_type = xml_doc.at("Report-Type")&.content
        ViewModel::SapWrapper.new(xml_doc, schema_type, report_type, additional_data)
      end
    end
  end
end
