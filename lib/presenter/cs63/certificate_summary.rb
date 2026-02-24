module Presenter
  module Cs63
    class CertificateSummary
      TYPE_OF_ASSESSMENT = "CS63".freeze

      def initialize(view_model)
        @view_model = view_model
      end

      def to_certificate_summary
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          epc_assessment_id: @view_model.epc_assessment_id,
          sale_lease_date: @view_model.sale_lease_date,
          report_type: @view_model.report_type,
          date_of_assessment: @view_model.assessment_date,
          plan_report_date: @view_model.plan_report_date,
          delegated_protocol_date: @view_model.delegated_protocol_date,
          address: {
            address_line1: @view_model.address_line1,
            address_line2: @view_model.address_line2,
            address_line3: @view_model.address_line3,
            address_line4: @view_model.address_line4,
            town: @view_model.town,
            postcode: @view_model.postcode,
          },
          assessor: {
            scheme_assessor_id: @view_model.scheme_assessor_id,
            name: @view_model.assessor_name,
            contact_details: {
              email: @view_model.assessor_email,
              telephone: @view_model.assessor_telephone,
              trading_address: @view_model.trading_address,
            },
            company_name: @view_model.company_name,
            status: @view_model.status,
          },
          owner_commission_report: @view_model.owner_commission_report,
          delegated_person_commission_report: @view_model.delegated_person_commission_report,
          property_type: {
            property_type_long_description: @view_model.property_type_long_description,
            property_type_short_description: @view_model.property_type_short_description,
          },
          building_improvements: @view_model.building_improvements,
          operational_ratings: @view_model.operational_ratings,
          dec: @view_model.dec,
          planned_completion_date: @view_model.planned_completion_date,
          actual_completion_date: @view_model.actual_completion_date,
          target_emission_savings: @view_model.target_emission_savings,
          target_energy_savings: @view_model.target_energy_savings,
          accept_prescriptive_improvements: @view_model.accept_prescriptive_improvements,
          prescriptive_improvements: @view_model.prescriptive_improvements,
          alternative_improvements: @view_model.alternative_improvements,
        }
      end
    end
  end
end
