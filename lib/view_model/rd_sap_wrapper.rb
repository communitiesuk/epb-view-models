module ViewModel
  class RdSapWrapper
    attr_reader :view_model, :schema_type

    def initialize(xml_doc, schema_type, additional_data = {})
      @schema_type = schema_type
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::RdSap::Summary.new(view_model)
      @certificate_summary = Presenter::RdSap::CertificateSummary.new(view_model)
      @report = Presenter::RdSap::Report.new(view_model, schema_type, additional_data)
      @recommendation_report = Presenter::RdSap::RecommendationReport.new(view_model)
      @domestic_digest = Presenter::RdSap::DomesticDigest.new(view_model, schema_type)
    end

    def type
      :RdSAP
    end

    def to_hash
      @summary.to_hash
    end

    def to_certificate_summary
      @certificate_summary.to_certificate_summary
    end

    def to_hash_ni
      @report.to_hash_ni
    end

    def to_report
      @report.to_hash
    end

    def to_recommendation_report
      @recommendation_report.to_hash
    end

    def to_domestic_digest
      @domestic_digest.to_domestic_digest
    end

    def to_hera_hash
      to_domestic_digest
    end

    extend Gem::Deprecate
    deprecate :to_hera_hash, :to_domestic_digest, 2022, 9

    def get_view_model
      view_model
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"RdSAP-Schema-21.0.1"
        ViewModel::RdSapSchema2101::CommonSchema.new xml_doc
      when :"RdSAP-Schema-21.0.0"
        ViewModel::RdSapSchema210::CommonSchema.new xml_doc
      when :"RdSAP-Schema-20.0.0"
        ViewModel::RdSapSchema200::CommonSchema.new xml_doc
      when :"RdSAP-Schema-19.0"
        ViewModel::RdSapSchema190::CommonSchema.new xml_doc
      when :"RdSAP-Schema-18.0"
        ViewModel::RdSapSchema180::CommonSchema.new xml_doc
      when :"RdSAP-Schema-17.1"
        ViewModel::RdSapSchema171::CommonSchema.new xml_doc
      when :"RdSAP-Schema-17.0"
        ViewModel::RdSapSchema170::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-21.0.0"
        ViewModel::RdSapSchemaNi210::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-20.0.0"
        ViewModel::RdSapSchemaNi200::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-19.0"
        ViewModel::RdSapSchemaNi190::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-18.0"
        ViewModel::RdSapSchemaNi180::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-17.4"
        ViewModel::RdSapSchemaNi174::CommonSchema.new xml_doc
      when :"RdSAP-Schema-NI-17.3"
        ViewModel::RdSapSchemaNi173::CommonSchema.new xml_doc
      when :"RdSAP-Schema-S-19.0"
        ViewModel::RdSapSchemaS190::CommonSchema.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
