module ViewModel
  class DecWrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type, additional_data = {})
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::Dec::Summary.new(view_model, schema_type)
      @report = Presenter::Dec::Report.new(view_model, additional_data)
    end

    def type
      :DEC
    end

    def to_hash
      @summary.to_hash
    end

    # create hash for data requested by Open Data Communities
    # hash keys will be turned into columns for expected csv
    def to_report
      @report.to_hash
    end

    def get_view_model
      view_model
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"DECAR-S-7.0"
        ViewModel::DecarS70::Dec.new xml_doc
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
      when :"CEPC-5.1"
        ViewModel::Cepc51::Dec.new xml_doc
      when :"CEPC-5.0"
        ViewModel::Cepc50::Dec.new xml_doc
      when :"CEPC-4.0"
        ViewModel::Cepc40::Dec.new xml_doc
      when :"CEPC-3.1"
        ViewModel::Cepc31::Dec.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
