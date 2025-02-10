module Presenter
  module RdSap
    class CertificateSummary
      TYPE_OF_ASSESSMENT = "RdSAP".freeze
      private_constant :TYPE_OF_ASSESSMENT

      def initialize(view_model)
        @view_model = view_model
      end

      def to_certificate_summary
        estimated_energy_cost =
          Helper::EstimatedCostPotentialSavingHelper.new.estimated_cost(
            @view_model.heating_cost_current,
            @view_model.hot_water_cost_current,
            @view_model.lighting_cost_current,
          )
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          date_of_expiry: @view_model.date_of_expiry,
          date_of_assessment: @view_model.date_of_assessment,
          date_of_registration: @view_model.date_of_registration,
          address: {
            address_line1: @view_model.address_line1,
            address_line2: @view_model.address_line2,
            address_line3: @view_model.address_line3,
            address_line4: nil,
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
          current_carbon_emission:
            convert_to_big_decimal(@view_model.current_carbon_emission),
          current_energy_efficiency_band: Helper::EnergyBandCalculator.domestic(@view_model.current_energy_rating),
          current_energy_efficiency_rating: @view_model.current_energy_rating,
          dwelling_type: @view_model.dwelling_type,
          estimated_energy_cost:,
          heat_demand: {
            current_space_heating_demand:
              @view_model.current_space_heating_demand&.to_i,
            current_water_heating_demand:
              @view_model.current_water_heating_demand&.to_i,
          },
          heating_cost_current: @view_model.heating_cost_current,
          heating_cost_potential: @view_model.heating_cost_potential,
          hot_water_cost_current: @view_model.hot_water_cost_current,
          hot_water_cost_potential: @view_model.hot_water_cost_potential,
          lighting_cost_current: @view_model.lighting_cost_current,
          lighting_cost_potential: @view_model.lighting_cost_potential,
          potential_carbon_emission:
            convert_to_big_decimal(@view_model.potential_carbon_emission),
          potential_energy_efficiency_band: Helper::EnergyBandCalculator.domestic(@view_model.potential_energy_rating),
          potential_energy_efficiency_rating: @view_model.potential_energy_rating,
          potential_energy_saving:
            Helper::EstimatedCostPotentialSavingHelper.new.potential_saving(
              @view_model.heating_cost_potential,
              @view_model.hot_water_cost_potential,
              @view_model.lighting_cost_potential,
              estimated_energy_cost,
            ),
          property_summary: @view_model.property_summary,
          recommended_improvements:
            @view_model.improvements.map do |improvement|
              improvement[:energy_performance_band_improvement] =
                Helper::EnergyBandCalculator.domestic(improvement[:energy_performance_rating_improvement])
              improvement
            end,
          lzc_energy_sources: @view_model.lzc_energy_sources,
          related_party_disclosure_number: @view_model.respond_to?(:related_party_disclosure_number) ? @view_model.related_party_disclosure_number : nil,
          related_party_disclosure_text:
            @view_model.related_party_disclosure_text,
          total_floor_area: convert_to_big_decimal(@view_model.total_floor_area),
          status: @view_model.status,
          co2_emissions_current_per_floor_area:
            @view_model.co2_emissions_current_per_floor_area,
          addendum: @view_model.addendum,
          gas_smart_meter_present: @view_model.respond_to?(:gas_smart_meter_present) ? @view_model.gas_smart_meter_present : nil,
          electricity_smart_meter_present: @view_model.respond_to?(:electricity_smart_meter_present) ? @view_model.electricity_smart_meter_present : nil,
          country_code: @view_model.country_code,
        }
      end

    private

      def convert_to_big_decimal(node)
        return "" unless node

        BigDecimal(node, 0)
      end
    end
  end
end
