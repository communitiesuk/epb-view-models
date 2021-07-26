module ViewModel
  class DecSummaryWrapper
    class AssessmentNotSupported < StandardError
    end

    TYPE_OF_ASSESSMENT = "DEC".freeze
    private_constant :TYPE_OF_ASSESSMENT
    attr_reader :view_model

    def initialize(xml, schema_type)
      # Hack to use symbols, we need to update all callers to use symbols instead
      schema_type = schema_type.to_sym

      # FIXME: For some reasons the XML is received as a string and not a Nokogiri Document (like other wrappers)
      xml_doc = Nokogiri.XML(xml).remove_namespaces!
      @view_model = build_view_model(xml_doc, schema_type)
      @xml_summary = Presenter::Dec::XmlSummary.new(view_model)
    end

    def type
      :DEC
    end

    def to_xml
      @xml_summary.to_xml
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"CEPC-8.0.0"
        ViewModel::Cepc800::Dec.new xml_doc
      when :"CEPC-NI-8.0.0"
        ViewModel::CepcNi800::Dec.new xml_doc
      when :"CEPC-7.1"
        ViewModel::Cepc71::Dec.new xml_doc
      when :"CEPC-7.0"
        ViewModel::Cepc70::Dec.new xml_doc
      when :"CEPC-6.0"
        ViewModel::Cepc60::Dec.new xml_doc
      else
        raise AssessmentNotSupported
      end
    end
  end
end
