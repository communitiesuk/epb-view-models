module Presenter
  module AcCert
    class Summary
      TYPE_OF_ASSESSMENT = "AC-CERT".freeze

      def initialize(view_model)
        @view_model = view_model
      end

      def to_hash
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          report_type: @view_model.report_type,
          date_of_assessment: @view_model.date_of_assessment,
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
          technical_information: {
            date_of_assessment: @view_model.date_of_assessment,
            building_complexity: @view_model.building_complexity,
            calculation_tool: @view_model.calculation_tool,
            f_gas_compliant_date: @view_model.f_gas_compliant_date,
            ac_rated_output: @view_model.ac_rated_output,
            random_sampling: @view_model.random_sampling,
            treated_floor_area: @view_model.treated_floor_area,
            ac_system_metered: @view_model.ac_system_metered,
            refrigerant_charge: @view_model.refrigerant_charge,
          },
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
          related_rrn: @view_model.related_rrn,
          subsystems: @view_model.subsystems,
        }
      end
    end
  end
end
