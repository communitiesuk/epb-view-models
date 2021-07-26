module ViewModel
  class AcReportWrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type)
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::AcReport::Summary.new(view_model)
    end

    def type
      :AC_REPORT
    end

    def to_hash
      @summary.to_hash
    end

    def get_view_model
      view_model
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"CEPC-8.0.0"
        ViewModel::Cepc800::AcReport.new xml_doc
      when :"CEPC-NI-8.0.0"
        ViewModel::CepcNi800::AcReport.new xml_doc
      when :"CEPC-7.1"
        ViewModel::Cepc71::AcReport.new xml_doc
      when :"CEPC-7.0"
        ViewModel::Cepc70::AcReport.new xml_doc
      when :"CEPC-6.0"
        ViewModel::Cepc60::AcReport.new xml_doc
      when :"CEPC-5.1"
        ViewModel::Cepc51::AcReport.new xml_doc
      when :"CEPC-5.0"
        ViewModel::Cepc50::AcReport.new xml_doc
      when :"CEPC-4.0"
        ViewModel::Cepc40::AcReport.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
