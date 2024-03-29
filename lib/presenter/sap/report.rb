module Presenter
  module Sap
    class Report
      def initialize(view_model, schema_type, additional_data)
        @view_model = view_model
        @schema_type = schema_type
        @additional_data = additional_data
      end

      def to_hash
        report_from_assessment_xml
          .merge(report_from_additional_data)
      end

      def to_hash_ni
        report_from_ni_assessment_xml
      end

    private

      def report_from_ni_assessment_xml
        {
          address1: @view_model.address_line1,
          address2: @view_model.address_line2,
          address3: @view_model.address_line3,
          built_form:
            Helper::XmlEnumsToOutput.built_form_string(@view_model.built_form),
          co2_emiss_curr_per_floor_area:
            @view_model.co2_emissions_current_per_floor_area,
          co2_emissions_current: @view_model.current_carbon_emission,
          co2_emissions_potential: @view_model.potential_carbon_emission,
          construction_age_band:
            Helper::XmlEnumsToOutput.construction_age_band_lookup(
              @view_model.main_dwelling_construction_age_band_or_year,
              @schema_type,
              @view_model.report_type,
            ),
          current_energy_efficiency: @view_model.current_energy_rating,
          current_energy_rating:
            Helper::EnergyBandCalculator.domestic(@view_model.current_energy_rating),
          cylinder_insul_thickness: @view_model.cylinder_insul_thickness,
          cylinder_insulation_type: @view_model.cylinder_insulation_type,
          cylinder_size: @view_model.cylinder_size,
          has_cylinder_thermostat: @view_model.respond_to?(:has_cylinder_thermostat) ? @view_model.has_cylinder_thermostat : nil,
          energy_consumption_current: @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use : nil,
          energy_consumption_potential: @view_model.energy_consumption_potential,
          energy_tariff:
            Helper::XmlEnumsToOutput.energy_tariff(
              @view_model.energy_tariff,
              @view_model.report_type,
            ),
          environment_impact_current: @view_model.environmental_impact_current,
          environment_impact_potential:
            @view_model.environmental_impact_potential,
          extension_count: @view_model.respond_to?(:extensions_count) ? @view_model.extensions_count : nil,
          fixed_lighting_outlets_count: @view_model.respond_to?(:fixed_lighting_outlets_count) ? @view_model.fixed_lighting_outlets_count : nil,
          flat_storey_count: @view_model.respond_to?(:storey_count) ? @view_model.storey_count : nil,
          flat_top_storey: @view_model.top_storey,
          floor_description: @view_model.all_floor_descriptions.first,
          floor_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_floor_energy_efficiency_rating.first,
            ),
          floor_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_floor_env_energy_efficiency_rating.first,
            ),
          floor_height:
            if @view_model.respond_to?(:floor_height)
              @view_model.floor_height.first
            end,
          floor_level: @view_model.floor_level,
          glazed_area:
            Helper::XmlEnumsToOutput.glazed_area_rdsap(@view_model.respond_to?(:glazed_area) ? @view_model.glazed_area : nil),
          glazed_type:
            Helper::XmlEnumsToOutput.glazed_type_rdsap(
              @view_model.multi_glazing_type,
            ),
          heat_loss_corridor:
            Helper::XmlEnumsToOutput.heat_loss_corridor(
              @view_model.respond_to?(:heat_loss_corridor) ? @view_model.heat_loss_corridor : nil,
            ),
          heating_cost_current: @view_model.heating_cost_current,
          heating_cost_potential: @view_model.heating_cost_potential,
          hot_water_cost_current: @view_model.hot_water_cost_current,
          hot_water_cost_potential: @view_model.hot_water_cost_potential,
          hot_water_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.hot_water_energy_efficiency_rating,
            ),
          hot_water_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.hot_water_environmental_efficiency_rating,
            ),
          hotwater_description: @view_model.hot_water_description,
          inspection_date: @view_model.date_of_assessment,
          lighting_cost_current: @view_model.lighting_cost_current,
          lighting_cost_potential: @view_model.lighting_cost_potential,
          lighting_description: @view_model.lighting_description,
          lighting_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.lighting_energy_efficiency_rating,
            ),
          lighting_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.lighting_environmental_efficiency_rating,
            ),
          low_energy_lighting: @view_model.respond_to?(:low_energy_lighting) ? @view_model.low_energy_lighting : nil,
          low_energy_fixed_lighting_count:
            @view_model.respond_to?(:low_energy_fixed_lighting_outlets_count) ? @view_model.low_energy_fixed_lighting_outlets_count : nil,
          main_fuel:
            Helper::XmlEnumsToOutput.fuel_type(@view_model.main_fuel_type,
                                               @schema_type,
                                               @view_model.report_type),
          mainheat_description:
            @view_model.all_main_heating_descriptions.join(", "),
          mainheat_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_energy_efficiency.first,
            ),
          mainheat_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_environmental_efficiency.first,
            ),
          mainheatc_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_controls_energy_efficiency.first,
            ),
          mainheatc_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_controls_environmental_efficiency.first,
            ),
          mainheatcont_description:
            @view_model.all_main_heating_controls_descriptions.first,
          mains_gas_flag:
            @view_model.respond_to?(:mains_gas) ? @view_model.mains_gas : nil,
          mechanical_ventilation:
            Helper::XmlEnumsToOutput.mechanical_ventilation(
              @view_model.respond_to?(:mechanical_ventilation) ? @view_model.mechanical_ventilation : nil,
              @schema_type,
              @view_model.report_type,
            ),
          mech_vent_sys_index_number: @view_model.respond_to?(:mech_vent_sys_index_number) ? @view_model.mech_vent_sys_index_number : nil,
          mechanical_vent_data_source: @view_model.respond_to?(:mechanical_vent_data_source) ? @view_model.mechanical_vent_data_source : nil,
          multi_glaze_proportion: @view_model.respond_to?(:multiple_glazed_proportion) ? @view_model.multiple_glazed_proportion : nil,
          number_habitable_rooms: @view_model.respond_to?(:habitable_room_count) ? @view_model.habitable_room_count : nil,
          number_heated_rooms: @view_model.respond_to?(:heated_room_count) ? @view_model.heated_room_count : nil,
          number_open_fireplaces: @view_model.respond_to?(:open_fireplaces_count) ? @view_model.open_fireplaces_count : nil,
          photo_supply: @view_model.respond_to?(:photovoltaic_roof_area_percent) ? @view_model.photovoltaic_roof_area_percent : nil,
          postcode: @view_model.postcode,
          posttown: @view_model.town,
          potential_energy_efficiency: @view_model.potential_energy_rating,
          potential_energy_rating:
            Helper::EnergyBandCalculator.domestic(@view_model.potential_energy_rating),
          property_type:
            Helper::XmlEnumsToOutput.property_type(@view_model.property_type),
          report_type: @view_model.report_type,
          roof_description: @view_model.all_roof_descriptions.first,
          roof_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_roof_energy_efficiency_rating.first,
            ),
          roof_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_roof_env_energy_efficiency_rating.first,
            ),
          secondheat_description: @view_model.secondary_heating_description,
          sheating_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.secondary_heating_energy_efficiency_rating,
            ),
          sheating_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.secondary_heating_environmental_efficiency_rating,
            ),
          solar_water_heating_flag: @view_model.respond_to?(:solar_water_heating_flag) ? @view_model.solar_water_heating_flag : nil,
          thermal_store: @view_model.respond_to?(:thermal_store) ? @view_model.thermal_store : nil,
          tenure: Helper::XmlEnumsToOutput.tenure(@view_model.respond_to?(:tenure) ? @view_model.tenure : nil),
          total_floor_area: @view_model.total_floor_area,
          transaction_type:
            Helper::XmlEnumsToOutput.transaction_type(
              @view_model.respond_to?(:transaction_type) ? @view_model.transaction_type : nil,
              @view_model.report_type,
              @schema_type,
            ),
          ventilation_type: Helper::XmlEnumsToOutput.ventilation_type(@view_model.respond_to?(:ventilation_type) ? @view_model.ventilation_type : nil, @schema_type),
          unheated_corridor_length: @view_model.respond_to?(:unheated_corridor_length) ? @view_model.unheated_corridor_length : nil,
          water_heating_code: @view_model.water_heating_code,
          walls_description: @view_model.all_wall_descriptions.first,
          walls_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_wall_energy_efficiency_rating.first,
            ),
          walls_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_wall_env_energy_efficiency_rating.first,
            ),
          water_heating_fuel: Helper::XmlEnumsToOutput.fuel_type(
            @view_model.water_heating_fuel,
            @schema_type,
            @view_model.report_type,
          ),
          wind_turbine_count: @view_model.wind_turbine_count,
          windows_description: @view_model.window_description,
          windows_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.window_energy_efficiency_rating,
            ),
          windows_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.window_environmental_efficiency_rating,
            ),
        }
      end

      def report_from_assessment_xml
        {
          assessment_id: Helper::RrnHelper.hash_rrn(@view_model.assessment_id),
          inspection_date: @view_model.date_of_assessment,
          lodgement_date: @view_model.date_of_registration,
          address1: @view_model.address_line1,
          address2: @view_model.address_line2,
          address3: @view_model.address_line3,
          posttown: @view_model.town,
          postcode: @view_model.postcode,
          construction_age_band:
            Helper::XmlEnumsToOutput.construction_age_band_lookup(
              @view_model.main_dwelling_construction_age_band_or_year,
              @schema_type,
              @view_model.report_type,
            ),
          current_energy_rating:
            Helper::EnergyBandCalculator.domestic(@view_model.current_energy_rating),
          potential_energy_rating:
            Helper::EnergyBandCalculator.domestic(@view_model.potential_energy_rating),
          current_energy_efficiency: @view_model.current_energy_rating,
          potential_energy_efficiency: @view_model.potential_energy_rating,
          property_type:
            Helper::XmlEnumsToOutput.property_type(@view_model.property_type),
          tenure: Helper::XmlEnumsToOutput.tenure(@view_model.respond_to?(:tenure) ? @view_model.tenure : nil),
          transaction_type:
            Helper::XmlEnumsToOutput.transaction_type(
              @view_model.respond_to?(:transaction_type) ? @view_model.transaction_type : nil,
              @view_model.report_type,
            ),
          environment_impact_current: @view_model.environmental_impact_current,
          environment_impact_potential:
            @view_model.environmental_impact_potential,
          energy_consumption_current: @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use : nil,
          energy_consumption_potential: @view_model.energy_consumption_potential,
          co2_emissions_current: @view_model.current_carbon_emission,
          co2_emiss_curr_per_floor_area:
            @view_model.co2_emissions_current_per_floor_area,
          co2_emissions_potential: @view_model.potential_carbon_emission,
          heating_cost_current: @view_model.heating_cost_current,
          heating_cost_potential: @view_model.heating_cost_potential,
          hot_water_cost_current: @view_model.hot_water_cost_current,
          hot_water_cost_potential: @view_model.hot_water_cost_potential,
          lighting_cost_current: @view_model.lighting_cost_current,
          lighting_cost_potential: @view_model.lighting_cost_potential,
          total_floor_area: @view_model.total_floor_area,
          mains_gas_flag:
            @view_model.respond_to?(:mains_gas) ? @view_model.mains_gas : nil,
          flat_top_storey: @view_model.top_storey,
          flat_storey_count: @view_model.respond_to?(:storey_count) ? @view_model.storey_count : nil,
          multi_glaze_proportion: @view_model.respond_to?(:multiple_glazed_proportion) ? @view_model.multiple_glazed_proportion : nil,
          glazed_area:
            Helper::XmlEnumsToOutput.glazed_area_rdsap(@view_model.respond_to?(:glazed_area) ? @view_model.glazed_area : nil),
          number_habitable_rooms: @view_model.respond_to?(:habitable_room_count) ? @view_model.habitable_room_count : nil,
          number_heated_rooms: @view_model.respond_to?(:heated_room_count) ? @view_model.heated_room_count : nil,
          low_energy_lighting: @view_model.respond_to?(:low_energy_lighting) ? @view_model.low_energy_lighting : nil,
          fixed_lighting_outlets_count: @view_model.respond_to?(:fixed_lighting_outlets_count) ? @view_model.fixed_lighting_outlets_count : nil,
          low_energy_fixed_lighting_outlets_count:
            @view_model.respond_to?(:low_energy_fixed_lighting_outlets_count) ? @view_model.low_energy_fixed_lighting_outlets_count : nil,
          number_open_fireplaces: @view_model.respond_to?(:open_fireplaces_count) ? @view_model.open_fireplaces_count : nil,
          hotwater_description: @view_model.hot_water_description,
          hot_water_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.hot_water_energy_efficiency_rating,
            ),
          hot_water_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.hot_water_environmental_efficiency_rating,
            ),
          wind_turbine_count: @view_model.wind_turbine_count,
          heat_loss_corridor:
            Helper::XmlEnumsToOutput.heat_loss_corridor(
              @view_model.respond_to?(:heat_loss_corridor) ? @view_model.heat_loss_corridor : nil,
            ),
          unheated_corridor_length: @view_model.respond_to?(:unheated_corridor_length) ? @view_model.unheated_corridor_length : nil,
          windows_description: @view_model.window_description,
          windows_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.window_energy_efficiency_rating,
            ),
          windows_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.window_environmental_efficiency_rating,
            ),
          sheating_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.secondary_heating_energy_efficiency_rating,
            ),
          sheating_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.secondary_heating_environmental_efficiency_rating,
            ),
          secondheat_description: @view_model.secondary_heating_description,
          lighting_description: @view_model.lighting_description,
          lighting_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.lighting_energy_efficiency_rating,
            ),
          lighting_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.lighting_environmental_efficiency_rating,
            ),
          photo_supply: @view_model.respond_to?(:photovoltaic_roof_area_percent) ? @view_model.photovoltaic_roof_area_percent : nil,
          built_form:
            Helper::XmlEnumsToOutput.built_form_string(@view_model.built_form),
          mainheat_description:
            @view_model.all_main_heating_descriptions.join(", "),
          report_type: @view_model.report_type,
          mainheatcont_description:
            @view_model.all_main_heating_controls_descriptions.first,
          roof_description: @view_model.all_roof_descriptions.first,
          roof_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_roof_energy_efficiency_rating.first,
            ),
          roof_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_roof_env_energy_efficiency_rating.first,
            ),
          walls_description: @view_model.all_wall_descriptions.first,
          walls_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_wall_energy_efficiency_rating.first,
            ),
          walls_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_wall_env_energy_efficiency_rating.first,
            ),
          energy_tariff:
            Helper::XmlEnumsToOutput.energy_tariff(
              @view_model.energy_tariff,
              @view_model.report_type,
            ),
          floor_level: @view_model.floor_level,
          mainheat_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_energy_efficiency.first,
            ),
          mainheat_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_environmental_efficiency.first,
            ),
          extension_count: @view_model.respond_to?(:extensions_count) ? @view_model.extensions_count : nil,
          solar_water_heating_flag: @view_model.respond_to?(:solar_water_heating_flag) ? @view_model.solar_water_heating_flag : nil,
          mechanical_ventilation:
            Helper::XmlEnumsToOutput.mechanical_ventilation(
              @view_model.respond_to?(:mechanical_ventilation) ? @view_model.mechanical_ventilation : nil,
              @schema_type,
              @view_model.report_type,
            ),
          floor_height:
            if @view_model.respond_to?(:floor_height)
              @view_model.floor_height.first
            end,
          main_fuel:
            Helper::XmlEnumsToOutput.fuel_type(@view_model.main_fuel_type,
                                               @schema_type,
                                               @view_model.report_type),
          floor_description: @view_model.all_floor_descriptions.first,
          floor_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_floor_energy_efficiency_rating.first,
            ),
          floor_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_floor_env_energy_efficiency_rating.first,
            ),
          mainheatc_energy_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_controls_energy_efficiency.first,
            ),
          mainheatc_env_eff:
            Helper::XmlEnumsToOutput.energy_rating_string(
              @view_model.all_main_heating_controls_environmental_efficiency.first,
            ),
          glazed_type:
            Helper::XmlEnumsToOutput.glazed_type_rdsap(
              @view_model.multi_glazing_type,
            ),
        }
      end

      def report_from_additional_data
        report = {}

        if @additional_data.key?(:date_registered)
          report[:lodgement_date] = @additional_data[:date_registered].strftime("%F")
        end
        if @additional_data.key?(:created_at)
          report[:lodgement_datetime] = @additional_data[:created_at].strftime("%F %H:%M:%S")
        end
        if @additional_data.key?(:address_id)
          report[:building_reference_number] =
            if @additional_data[:address_id].include?("UPRN")
              @additional_data[:address_id]
            end
        end
        if @additional_data.key?(:postcode_region)
          report[:region] = @additional_data[:postcode_region]
        elsif @additional_data.key?(:outcode_region)
          report[:region] = @additional_data[:outcode_region]
        end

        report
      end
    end
  end
end
