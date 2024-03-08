module Presenter
  module Cepc
    class Summary
      TYPE_OF_ASSESSMENT = "CEPC".freeze

      def initialize(view_model)
        @view_model = view_model
      end

      def to_hash
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          date_of_expiry: @view_model.date_of_expiry,
          report_type: @view_model.report_type,
          date_of_assessment: @view_model.date_of_assessment,
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
            main_heating_fuel: @view_model.main_heating_fuel,
            building_environment: @view_model.building_environment,
            floor_area: @view_model.floor_area,
            building_level: @view_model.building_level,
          },
          building_emission_rate: @view_model.respond_to?(:building_emission_rate) ? @view_model.building_emission_rate : nil,
          primary_energy_use: @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use : nil,
          related_rrn: @view_model.related_rrn,
          new_build_rating: @view_model.new_build_rating,
          new_build_band:
            Helper::EnergyBandCalculator.commercial(
              @view_model.new_build_rating.to_i,
            ),
          existing_build_rating: @view_model.existing_build_rating,
          existing_build_band:
            Helper::EnergyBandCalculator.commercial(
              @view_model.existing_build_rating.to_i,
            ),
          current_energy_efficiency_rating: @view_model.energy_efficiency_rating,
          energy_efficiency_rating: @view_model.energy_efficiency_rating,
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
          related_party_disclosure: @view_model.epc_related_party_disclosure,
          current_energy_efficiency_band:
            Helper::EnergyBandCalculator.commercial(
              @view_model.energy_efficiency_rating.to_i,
            ),
          property_type: @view_model.property_type,
          building_complexity: @view_model.building_level,
        }
      end
    end
  end
end
