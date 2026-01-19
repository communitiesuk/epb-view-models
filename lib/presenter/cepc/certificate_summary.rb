module Presenter
  module Cepc
    class CertificateSummary
      TYPE_OF_ASSESSMENT = "CEPC".freeze

      def initialize(view_model)
        @view_model = view_model
      end

      def to_certificate_summary
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          date_of_expiry: @view_model.date_of_expiry,
          report_type: @view_model.report_type,
          date_of_assessment: @view_model.date_of_assessment,
          date_of_registration: @view_model.date_of_registration,
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
            },
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
          new_build_band: Helper::EnergyBandCalculator.commercial(@view_model.new_build_rating),
          existing_build_rating: @view_model.existing_build_rating,
          existing_build_band: Helper::EnergyBandCalculator.commercial(@view_model.existing_build_rating),
          current_energy_efficiency_rating: @view_model.energy_efficiency_rating,
          energy_efficiency_rating: @view_model.energy_efficiency_rating,
          related_party_disclosure: @view_model.epc_related_party_disclosure,
          current_energy_efficiency_band: Helper::EnergyBandCalculator.commercial(@view_model.energy_efficiency_rating),
          property_type: @view_model.property_type,
          building_complexity: @view_model.building_level,
        }
      end

      def to_certificate_summary_scotland
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          date_of_expiry: @view_model.date_of_expiry,
          report_type: @view_model.report_type,
          date_of_assessment: @view_model.date_of_assessment,
          date_of_registration: @view_model.date_of_registration,
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
            },
          },
          technical_information: {
            main_heating_fuel: @view_model.main_heating_fuel,
            building_environment: @view_model.building_environment,
            floor_area: @view_model.floor_area,
          },
          # primary_energy_use: @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use : nil,
          # new_build_rating: @view_model.new_build_rating,
          # new_build_band: Helper::EnergyBandCalculator.commercial(@view_model.new_build_rating),
          # existing_build_rating: @view_model.existing_build_rating,
          # existing_build_band: Helper::EnergyBandCalculator.commercial(@view_model.existing_build_rating),
          current_energy_efficiency_rating: @view_model.energy_efficiency_rating,
          # energy_efficiency_rating: @view_model.energy_efficiency_rating,
          current_energy_efficiency_band: Helper::EnergyBandCalculator.commercial(@view_model.energy_efficiency_rating),
          property_type: @view_model.property_type,
          property_short_description: @view_model.property_short_description,
          compliant_2002: @view_model.compliant_2002,
          renewable_energy_sources: @view_model.renewable_energy_sources,
          electricity_sources: @view_model.electricity_sources,
          primary_energy_indicator: @view_model.primary_energy_indicator,
          calculation_tool: @view_model.calculation_tool,
          ter_2002: @view_model.ter_2002,
          ter: @view_model.ter,
          recommendations: [
            @view_model.short_payback_recommendations.map do |recommendation|
              {
                payback_type: "short",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
            @view_model.medium_payback_recommendations.map do |recommendation|
              {
                payback_type: "medium",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
            @view_model.long_payback_recommendations.map do |recommendation|
              {
                payback_type: "long",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
            @view_model.other_recommendations.map do |recommendation|
              {
                payback_type: "other",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
          ].flatten,
        }
      end
    end
  end
end
