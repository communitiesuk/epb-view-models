module Presenter
  module AcReport
    class Summary
      TYPE_OF_ASSESSMENT = "AC-REPORT".freeze

      def initialize(view_model)
        @view_model = view_model
      end

      def to_hash
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          report_type: @view_model.report_type,
          date_of_assessment: @view_model.date_of_assessment,
          related_rrn: @view_model.related_rrn,
          date_of_expiry: @view_model.date_of_expiry,
          date_of_registration: @view_model.date_of_registration,
          address: {
            address_id: @view_model.address_id,
            address_line1: @view_model.address_line1,
            address_line2: @view_model.address_line2,
            address_line3: @view_model.address_line3,
            address_line4: @view_model.address_line4,
            town: @view_model.town,
            postcode: @view_model.postcode,
          },
          related_party_disclosure: @view_model.related_party_disclosure,
          assessor: {
            scheme_assessor_id: @view_model.scheme_assessor_id,
            name: @view_model.assessor_name,
            contact_details: {
              email: @view_model.assessor_email,
              telephone: @view_model.assessor_telephone,
            },
            company_details: {
              name: @view_model.company_name,
              address: @view_model.company_address,
            },
          },
          executive_summary: @view_model.executive_summary,
          key_recommendations: {
            efficiency: @view_model.key_recommendations_efficiency,
            maintenance: @view_model.key_recommendations_maintenance,
            control: @view_model.key_recommendations_control,
            management: @view_model.key_recommendations_management,
          },
          sub_systems: @view_model.sub_systems,
          pre_inspection_checklist: @view_model.pre_inspection_checklist,
          cooling_plants: @view_model.cooling_plants,
          air_handling_systems: @view_model.air_handling_systems,
          terminal_units: @view_model.terminal_units,
          system_controls: @view_model.system_controls,
        }
      end
    end
  end
end
