module ViewModel
  class Cs63Wrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type, additional_data = {})
      @view_model = ViewModel::Cs63::CommonSchema.new xml_doc
      # @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::Cs63::Summary.new(view_model)
    end

    def type
      :CS63
    end

    def to_hash
      @summary.to_hash
    end
    #
    # def get_report_type
    #   view_model.report_type
    # end

    def get_view_model
      view_model
    end

  private

    # def build_view_model(xml_doc, schema_type)
    #   case schema_type
    #   when :"CEPC-8.0.0"
    #     ViewModel::Cepc800::Cepc.new xml_doc
    #   when :"CEPC-NI-8.0.0"
    #     ViewModel::CepcNi800::Cepc.new xml_doc
    #   when :"CEPC-7.1"
    #     ViewModel::Cepc71::Cepc.new xml_doc
    #   when :"CEPC-7.0"
    #     ViewModel::Cepc70::Cepc.new xml_doc
    #   when :"CEPC-6.0"
    #     ViewModel::Cepc60::Cepc.new xml_doc
    #   when :"CEPC-5.1"
    #     ViewModel::Cepc51::Cepc.new xml_doc
    #   when :"CEPC-5.0"
    #     ViewModel::Cepc50::Cepc.new xml_doc
    #   when :"CEPC-4.0"
    #     ViewModel::Cepc40::Cepc.new xml_doc
    #   when :"CEPC-3.1"
    #     ViewModel::Cepc31::Cepc.new xml_doc
    #   when :"CEPC-S-7.1"
    #     ViewModel::CepcS71::Cepc.new xml_doc
    #   else
    #     raise ArgumentError, "Unsupported schema type"
    #   end
    # end
  end
end
