module Presenter
  module Sap
    class Summary
      def initialize(view_model)
        @view_model = view_model
      end

      def to_hash
        estimated_energy_cost =
          Helper::EstimatedCostPotentialSavingHelper.new.estimated_cost(
            @view_model.heating_cost_current,
            @view_model.hot_water_cost_current,
            @view_model.lighting_cost_current,
          )
        {
          type_of_assessment: @view_model.type_of_assessment,
          assessment_id: @view_model.assessment_id,
          date_of_expiry: @view_model.date_of_expiry,
          date_of_assessment: @view_model.date_of_assessment,
          date_of_registration: @view_model.date_of_registration,
          date_registered: @view_model.date_of_registration,
          address_id: @view_model.address_id,
          address_line1: @view_model.address_line1,
          address_line2: @view_model.address_line2,
          address_line3: @view_model.address_line3,
          address_line4: nil,
          town: @view_model.town,
          postcode: @view_model.postcode,
          address: {
            address_id: @view_model.address_id,
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
          main_fuel_type: @view_model.main_fuel_type,
          heat_demand: {
            current_space_heating_demand:
              @view_model.current_space_heating_demand&.to_i,
            current_water_heating_demand:
              @view_model.current_water_heating_demand&.to_i,
            impact_of_cavity_insulation: @view_model.respond_to?(:impact_of_cavity_insulation) ? @view_model.impact_of_cavity_insulation : nil,
            impact_of_loft_insulation: @view_model.respond_to?(:impact_of_loft_insulation) ? @view_model.impact_of_loft_insulation : nil,
            impact_of_solid_wall_insulation: @view_model.respond_to?(:impact_of_solid_wall_insulation) ? @view_model.impact_of_solid_wall_insulation : nil,
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
          primary_energy_use: @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use : nil,
          energy_consumption_potential: @view_model.energy_consumption_potential,
          property_age_band: @view_model.respond_to?(:property_age_band) ? @view_model.property_age_band : nil,
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
          tenure: @view_model.respond_to?(:tenure) ? @view_model.tenure : nil,
          transaction_type: @view_model.respond_to?(:transaction_type) ? @view_model.transaction_type : nil,
          total_floor_area: convert_to_big_decimal(@view_model.total_floor_area),
          total_roof_area: @view_model.respond_to?(:total_roof_area) ? @view_model.total_roof_area : nil,
          status: @view_model.status,
          environmental_impact_current: @view_model.environmental_impact_current,
          environmental_impact_potential:
            @view_model.environmental_impact_potential,
          co2_emissions_current_per_floor_area:
            @view_model.co2_emissions_current_per_floor_area,
          mains_gas: @view_model.respond_to?(:mains_gas) ? @view_model.mains_gas : nil,
          level: @view_model.level,
          top_storey: @view_model.top_storey,
          storey_count: @view_model.respond_to?(:storey_count) ? @view_model.storey_count : nil,
          main_heating_controls: @view_model.main_heating_controls,
          multiple_glazed_proportion: @view_model.respond_to?(:multiple_glazed_proportion) ? @view_model.multiple_glazed_proportion : nil,
          glazed_area: @view_model.respond_to?(:glazed_area) ? @view_model.glazed_area : nil,
          habitable_room_count: @view_model.respond_to?(:habitable_room_count) ? @view_model.habitable_room_count : nil,
          heated_room_count: @view_model.respond_to?(:heated_room_count) ? @view_model.heated_room_count : nil,
          low_energy_lighting: @view_model.respond_to?(:low_energy_lighting) ? @view_model.low_energy_lighting : nil,
          fixed_lighting_outlets_count: @view_model.respond_to?(:fixed_lighting_outlets_count) ? @view_model.fixed_lighting_outlets_count : nil,
          low_energy_fixed_lighting_outlets_count:
            @view_model.respond_to?(:low_energy_fixed_lighting_outlets_count) ? @view_model.low_energy_fixed_lighting_outlets_count : nil,
          open_fireplaces_count: @view_model.respond_to?(:open_fireplaces_count) ? @view_model.open_fireplaces_count : nil,
          hot_water_description: @view_model.hot_water_description,
          hot_water_energy_efficiency_rating:
            @view_model.hot_water_energy_efficiency_rating,
          hot_water_environmental_efficiency_rating:
            @view_model.hot_water_environmental_efficiency_rating,
          window_description: @view_model.window_description,
          window_energy_efficiency_rating:
            @view_model.window_energy_efficiency_rating,
          window_environmental_efficiency_rating:
            @view_model.window_environmental_efficiency_rating,
          secondary_heating_description:
            @view_model.secondary_heating_description,
          secondary_heating_energy_efficiency_rating:
            @view_model.secondary_heating_energy_efficiency_rating,
          secondary_heating_environmental_efficiency_rating:
            @view_model.secondary_heating_environmental_efficiency_rating,
          lighting_description: @view_model.lighting_description,
          lighting_energy_efficiency_rating:
            @view_model.lighting_energy_efficiency_rating,
          lighting_environmental_efficiency_rating:
            @view_model.lighting_environmental_efficiency_rating,
          photovoltaic_roof_area_percent: @view_model.respond_to?(:photovoltaic_roof_area_percent) ? @view_model.photovoltaic_roof_area_percent : nil,
          heat_loss_corridor: @view_model.respond_to?(:heat_loss_corridor) ? @view_model.heat_loss_corridor : nil,
          wind_turbine_count: @view_model.wind_turbine_count,
          unheated_corridor_length: @view_model.respond_to?(:unheated_corridor_length) ? @view_model.unheated_corridor_length : nil,
          built_form:
            Helper::XmlEnumsToOutput.built_form_string(@view_model.built_form),
          mainheat_description:
            @view_model.all_main_heating_descriptions.join(", "),
          extensions_count: @view_model.respond_to?(:extensions_count) ? @view_model.extensions_count : nil,
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
