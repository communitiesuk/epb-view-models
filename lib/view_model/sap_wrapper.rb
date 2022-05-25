module ViewModel
  class SapWrapper
    attr_reader :view_model, :schema_type

    def initialize(xml_doc, schema_type, report_type = "3", additional_data = {})
      @schema_type = schema_type
      @view_model = build_view_model(xml_doc, schema_type, report_type)
      @summary = Presenter::Sap::Summary.new(view_model)
      @report = Presenter::Sap::Report.new(view_model, schema_type, additional_data)
      @recommendation_report = Presenter::Sap::RecommendationReport.new(view_model)
      @hera = Presenter::Sap::Hera.new(view_model)
    end

    def type
      view_model.type_of_assessment.to_sym
    end

    def to_hash
      @summary.to_hash
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

    def to_hera_hash
      @hera.to_hera_hash
    end

    def get_view_model
      view_model
    end

  private

    def build_view_model(xml_doc, schema_type, report_type)
      case schema_type
      when :"SAP-Schema-19.0.0"
        return ViewModel::SapSchema1900::CommonSchema.new xml_doc
      when :"SAP-Schema-18.0.0"
        return ViewModel::SapSchema1800::CommonSchema.new xml_doc
      when :"SAP-Schema-17.1"
        return ViewModel::SapSchema171::CommonSchema.new xml_doc
      when :"SAP-Schema-17.0"
        return ViewModel::SapSchema170::CommonSchema.new xml_doc
      when :"SAP-Schema-16.3"
        case report_type
        when "2"
          return ViewModel::SapSchema163::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema163::Sap.new(xml_doc)
        end
      when :"SAP-Schema-16.2"
        case report_type
        when "2"
          return ViewModel::SapSchema162::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema162::Sap.new(xml_doc)
        end
      when :"SAP-Schema-16.1"
        case report_type
        when "2"
          return ViewModel::SapSchema161::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema161::Sap.new(xml_doc)
        end
      when :"SAP-Schema-16.0"
        case report_type
        when "2"
          return ViewModel::SapSchema160::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema160::Sap.new(xml_doc)
        end
      when :"SAP-Schema-15.0"
        case report_type
        when "2"
          return ViewModel::SapSchema150::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema150::Sap.new(xml_doc)
        end
      when :"SAP-Schema-14.2"
        case report_type
        when "2"
          return ViewModel::SapSchema142::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema142::Sap.new(xml_doc)
        end
      when :"SAP-Schema-14.1"
        case report_type
        when "2"
          return ViewModel::SapSchema141::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema141::Sap.new(xml_doc)
        end
      when :"SAP-Schema-14.0"
        case report_type
        when "2"
          return ViewModel::SapSchema140::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema140::Sap.new(xml_doc)
        end
      when :"SAP-Schema-13.0"
        case report_type
        when "2"
          return ViewModel::SapSchema130::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema130::Sap.new(xml_doc)
        end
      when :"SAP-Schema-12.0"
        case report_type
        when "2"
          return ViewModel::SapSchema120::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema120::Sap.new(xml_doc)
        end
      when :"SAP-Schema-11.2"
        case report_type
        when "2"
          return ViewModel::SapSchema112::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema112::Sap.new(xml_doc)
        end
      when :"SAP-Schema-11.0"
        case report_type
        when "2"
          return ViewModel::SapSchema110::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchema110::Sap.new(xml_doc)
        end
      when :"SAP-Schema-10.2"
        return ViewModel::SapSchema102::Rdsap.new(xml_doc) if report_type == "2"
      when :"SAP-Schema-NI-18.0.0"
        return ViewModel::SapSchemaNi1800::CommonSchema.new xml_doc
      when :"SAP-Schema-NI-17.4"
        return ViewModel::SapSchemaNi174::CommonSchema.new xml_doc
      when :"SAP-Schema-NI-17.3"
        return ViewModel::SapSchemaNi173::CommonSchema.new xml_doc
      when :"SAP-Schema-NI-17.2"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi172::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi172::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-17.1"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi171::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi171::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-17.0"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi170::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi170::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-16.1"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi161::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi161::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-16.0"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi160::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi160::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-15.0"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi150::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi150::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-14.2"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi142::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi142::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-14.1"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi141::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi141::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-14.0"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi140::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi140::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-13.0"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi130::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi130::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-12.0"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi120::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi120::Sap.new(xml_doc)
        end
      when :"SAP-Schema-NI-11.2"
        case report_type
        when "2"
          return ViewModel::SapSchemaNi112::Rdsap.new(xml_doc)
        when "3"
          return ViewModel::SapSchemaNi112::Sap.new(xml_doc)
        end
      end

      raise ArgumentError, "Unsupported schema type"
    end
  end
end
