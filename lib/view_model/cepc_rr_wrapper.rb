module ViewModel
  class CepcRrWrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type)
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::CepcRr::Summary.new(view_model)
      @recommendation_report = Presenter::CepcRr::RecommendationReport.new(view_model)
    end

    def type
      :CEPC_RR
    end

    def to_hash
      @summary.to_hash
    end

    # FIXME: Method name is not consistent for recommendation reports (see SAP/RdSAP)
    def to_report
      @recommendation_report.to_hash
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"CEPC-8.0.0"
        ViewModel::Cepc800::CepcRr.new xml_doc
      when :"CEPC-NI-8.0.0"
        ViewModel::CepcNi800::CepcRr.new xml_doc
      when :"CEPC-7.1"
        ViewModel::Cepc71::CepcRr.new xml_doc
      when :"CEPC-7.0"
        ViewModel::Cepc70::CepcRr.new xml_doc
      when :"CEPC-6.0"
        ViewModel::Cepc60::CepcRr.new xml_doc
      when :"CEPC-5.1"
        ViewModel::Cepc51::CepcRr.new xml_doc
      when :"CEPC-5.0"
        ViewModel::Cepc50::CepcRr.new xml_doc
      when :"CEPC-4.0"
        ViewModel::Cepc40::CepcRr.new xml_doc
      when :"CEPC-3.1"
        ViewModel::Cepc31::CepcRr.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
