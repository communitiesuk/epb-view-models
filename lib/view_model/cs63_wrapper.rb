module ViewModel
  class Cs63Wrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type, _additional_data = {})
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::Cs63::Summary.new(view_model)
      @certificate_summary = Presenter::Cs63::CertificateSummary.new(view_model)
    end

    def type
      :CS63
    end

    def to_hash
      @summary.to_hash
    end

    def to_certificate_summary
      @certificate_summary.to_certificate_summary
    end

    def get_view_model
      view_model
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"CS63-S-7.0"
        ViewModel::Cs6370::CommonSchema.new xml_doc
      when :"CS63-S-8.0.0"
        ViewModel::Cs63800::CommonSchema.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
