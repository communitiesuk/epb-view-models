module ViewModel
  module SapSchemaS1900
    class CommonSchema < ViewModel::DomesticEpcViewModel
      THRESHOLD_LOW_ENERGY_LIGHTING_EFFICACY = 65

      def assessment_id
        xpath(%w[Report-Header RRN])
      end

      def address_line1
        xpath(%w[Report-Header Property Address Address-Line-1])
      end

      def address_line2
        xpath(%w[Report-Header Property Address Address-Line-2])
      end

      def address_line3
        xpath(%w[Report-Header Property Address Address-Line-3])
      end

      def town
        xpath(%w[Report-Header Property Address Post-Town])
      end

      def postcode
        xpath(%w[Report-Header Property Address Postcode])
      end

      def scheme_assessor_id
        xpath(%w[Certificate-Number])
      end

      def assessor_name
        xpath(%w[Home-Inspector Name])
      end

      def assessor_email
        xpath(%w[Home-Inspector/E-Mail])
      end

      def assessor_telephone
        xpath(%w[Home-Inspector/Telephone])
      end

      def date_of_assessment
        xpath(%w[Inspection-Date])
      end

      def date_of_registration
        xpath(%w[Registration-Date])
      end

      def date_of_completion
        xpath(%w[Completion-Date])
      end

      def address_id
        xpath(%w[UPRN])
      end

      def date_of_expiry
        expires_at = (Date.parse(date_of_registration) - 1) >> 12 * 10

        expires_at.to_s
      end

      def property_summary
        @xml_doc.search("Energy-Assessment Property-Summary").children.select(
          &:element?
        ).map { |node|
          next if xpath(%w[Energy-Efficiency-Rating], node).nil?

          {
            energy_efficiency_rating:
              xpath(%w[Energy-Efficiency-Rating], node).to_i,
            environmental_efficiency_rating:
              xpath(%w[Environmental-Efficiency-Rating], node).to_i,
            name: node.name.underscore,
            description: xpath(%w[Description], node),
          }
        }.compact
      end

      def related_party_disclosure_text
        xpath(%w[Related-Party-Disclosure-Text])
      end

      def related_party_disclosure_number
        xpath(%w[Related-Party-Disclosure-Number])&.to_i
      end

      def improvements
        @xml_doc
          .search("Suggested-Improvements Improvement")
          .map do |node|
            {
              energy_performance_rating_improvement:
                xpath(%w[Energy-Performance-Rating], node).to_i,
              environmental_impact_rating_improvement:
                xpath(%w[Environmental-Impact-Rating], node).to_i,
              green_deal_category_code: xpath(%w[Green-Deal-Category], node),
              improvement_category: xpath(%w[Improvement-Category], node),
              improvement_code:
                xpath(%w[Improvement-Details Improvement-Number], node),
              improvement_description: xpath(%w[Improvement-Description], node),
              improvement_title: improvement_title(node),
              improvement_type: xpath(%w[Improvement-Type], node),
              indicative_cost: xpath(%w[Indicative-Cost], node),
              sequence: xpath(%w[Sequence], node).to_i,
              typical_saving: xpath(%w[Typical-Saving], node),
            }
          end
      end

      def recommendations_for_report
        accessor = Accessor::DomesticRecommendationsAccessor.instance
        @xml_doc
          .search("Suggested-Improvements Improvement")
          .map do |node|
            improvement_code = xpath(%w[Improvement-Details Improvement-Number], node)
            {
              sequence: xpath(%w[Sequence], node).to_i,
              improvement_summary: improvement_code ? accessor.fetch_details(schema_version: "SAP-Schema-19.0.0", improvement_number: improvement_code).summary : xpath(%w[Improvement-Summary], node),
              improvement_description: improvement_code ? accessor.fetch_details(schema_version: "SAP-Schema-19.0.0", improvement_number: improvement_code).description : xpath(%w[Improvement-Description], node),
              improvement_code:
                xpath(%w[Improvement-Details Improvement-Number], node),
              indicative_cost: xpath(%w[Indicative-Cost], node),
            }
          end
      end

      def hot_water_cost_potential
        xpath(%w[Hot-Water-Cost-Potential])
      end

      def heating_cost_potential
        xpath(%w[Heating-Cost-Potential])
      end

      def lighting_cost_potential
        xpath(%w[Lighting-Cost-Potential])
      end

      def hot_water_cost_current
        xpath(%w[Hot-Water-Cost-Current])
      end

      def heating_cost_current
        xpath(%w[Heating-Cost-Current])
      end

      def lighting_cost_current
        xpath(%w[Lighting-Cost-Current])
      end

      def potential_carbon_emission
        xpath(%w[CO2-Emissions-Potential])
      end

      def current_carbon_emission
        xpath(%w[CO2-Emissions-Current])
      end

      def potential_energy_rating
        xpath(%w[Energy-Rating-Potential])&.to_i
      end

      def current_energy_rating
        xpath(%w[Energy-Rating-Current])&.to_i
      end

      def primary_energy_use
        xpath(%w[Energy-Consumption-Current])
      end

      def energy_consumption_potential
        xpath(%w[Energy-Consumption-Potential])
      end

      def estimated_energy_cost; end

      def total_floor_area
        xpath(%w[Property-Summary Total-Floor-Area])&.to_i
      end

      def total_roof_area
        roofs = @xml_doc.xpath("//SAP-Roofs/SAP-Roof")
        return nil if roofs.count.zero?

        total_roof_area = 0
        roofs.each do |roof|
          roof_area = roof.at("Total-Roof-Area")&.content.to_i
          total_roof_area += roof_area
        end
        total_roof_area
      end

      def dwelling_type
        xpath(%w[Dwelling-Type])
      end

      def potential_energy_saving; end

      def property_age_band
        xpath(%w[Construction-Year])
      end

      def main_dwelling_construction_age_band_or_year
        sap_building_parts =
          @xml_doc.xpath("//SAP-Building-Parts/SAP-Building-Part")
        sap_building_parts.each do |sap_building_part|
          building_part_number = sap_building_part.at("Building-Part-Number")

          # Identifies the Main Dwelling
          if building_part_number&.content == "1"
            return(
              sap_building_part.at_xpath(
                "Construction-Age-Band | Construction-Year",
              )&.content
            )
          end
        end
        nil
      end

      def tenure
        xpath(%w[Tenure])
      end

      def transaction_type
        xpath(%w[Transaction-Type])
      end

      def current_space_heating_demand
        xpath(%w[Space-Heating]) or xpath(%w[Space-Heating-Existing-Dwelling])
      end

      def current_water_heating_demand
        xpath(%w[Water-Heating])
      end

      def impact_of_cavity_insulation
        if xpath(%w[Impact-Of-Cavity-Insulation])
          xpath(%w[Impact-Of-Cavity-Insulation])&.to_i
        end
      end

      def impact_of_loft_insulation
        if xpath(%w[Impact-Of-Loft-Insulation])
          xpath(%w[Impact-Of-Loft-Insulation])&.to_i
        end
      end

      def impact_of_solid_wall_insulation
        if xpath(%w[Impact-Of-Solid-Wall-Insulation])
          xpath(%w[Impact-Of-Solid-Wall-Insulation])&.to_i
        end
      end

      def all_sap_floor_dimensions
        @xml_doc.search("SAP-Floor-Dimension").select(&:element?).map { |node|
          { total_floor_area: xpath(%w[Total-Floor-Area], node).to_f }
        }.compact
      end

      def type_of_assessment
        "SAP"
      end

      def level
        xpath(%w[Level])
      end

      def top_storey
        flat_level_code = xpath(%w[SAP-FlatLevelCode])
        flat_level_code == "3" ? "Y" : "N"
      end

      def storey_count
        xpath(%w[Storeys])
      end

      def building_part_number
        xpath(%w[Building-Part-Number])
      end

      def all_building_parts
        @xml_doc
          .search("SAP-Building-Parts/SAP-Building-Part")
          .map do |part|
            {
              roof_insulation_thickness:
                if part.xpath("Roof-Insulation-Thickness").empty?
                  nil
                else
                  part.xpath("Roof-Insulation-Thickness").text
                end,
              rafter_insulation_thickness:
                xpath(%w[Rafter-Insulation-Thickness], part),
              flat_roof_insulation_thickness:
                xpath(%w[Flat-Roof-Insulation-Thickness], part),
              sloping_ceiling_insulation_thickness:
                xpath(%w[Sloping-Ceiling-Insulation-Thickness], part),
              roof_u_value: xpath(%w[Roof-U-Value], part),
            }
          end
      end

      def floor_heat_loss
        xpath(%w[Floor-Heat-Loss])
      end

      def immersion_heating_type
        xpath(%w[Immersion-Heating-Type])
      end

      def main_fuel_type
        xpath(%w[Main-Fuel-Type])
      end

      def secondary_fuel_type
        xpath(%w[Secondary-Fuel-Type])
      end

      def water_heating_fuel
        xpath(%w[Water-Fuel-Type])
      end

      def boiler_flue_type
        xpath(%w[Boiler-Flue-Type])
      end

      def meter_type
        xpath(%w[Meter-Type])
      end

      def sap_main_heating_code
        xpath(%w[SAP-Main-Heating-Code])
      end

      def country_code
        xpath(%w[Country-Code])
      end

      def environmental_impact_current
        xpath(%w[Environmental-Impact-Current])&.to_i
      end

      def environmental_impact_potential
        xpath(%w[Environmental-Impact-Potential])&.to_i
      end

      def co2_emissions_current_per_floor_area
        xpath(%w[CO2-Emissions-Current-Per-Floor-Area])
      end

      def main_heating_controls
        xpath(%w[Main-Heating-Controls Description])
      end

      def multiple_glazed_proportion
        xpath(%w[Multiple-Glazed-Percentage])
      end

      def fixed_lighting_outlets_count
        @xml_doc.search("Fixed-Lights/Fixed-Light/Lighting-Outlets").map(&:content).map(&:to_i).sum
      end

      def format_fixed_light_array
        @xml_doc
          .search("Fixed-Lights/Fixed-Light")
          .map do |part|
          {
            lighting_efficacy:
              xpath(%w[Lighting-Efficacy], part),
            lighting_outlets:
              xpath(%w[Lighting-Outlets], part),
          }
        end
      end

      def low_energy_lighting
        total_energy_outlet_count = []
        low_energy_outlet_count = []

        format_fixed_light_array.each do |outlet|
          if outlet[:lighting_efficacy].to_i > THRESHOLD_LOW_ENERGY_LIGHTING_EFFICACY
            low_energy_outlet_count << outlet[:lighting_outlets].to_i
          end
          total_energy_outlet_count << outlet[:lighting_outlets].to_f
        end

        if total_energy_outlet_count.sum.zero?
          return 0
        end

        (low_energy_outlet_count.sum / total_energy_outlet_count.sum * 100).round
      end

      def low_energy_fixed_lighting_outlets_count
        low_energy_outlet_count = []

        format_fixed_light_array.each do |outlet|
          if outlet[:lighting_efficacy].to_i > THRESHOLD_LOW_ENERGY_LIGHTING_EFFICACY
            low_energy_outlet_count << outlet[:lighting_outlets].to_i
          end
        end

        low_energy_outlet_count.sum
      end

      def open_fireplaces_count
        xpath(%w[Open-Chimneys-Count])&.to_i
      end

      def hot_water_description
        xpath(%w[Hot-Water Description])
      end

      def hot_water_energy_efficiency_rating
        xpath(%w[Hot-Water Energy-Efficiency-Rating])
      end

      def hot_water_environmental_efficiency_rating
        xpath(%w[Hot-Water Environmental-Efficiency-Rating])
      end

      def window_description
        xpath(%w[Windows Description])
      end

      def window_energy_efficiency_rating
        xpath(%w[Windows Energy-Efficiency-Rating])
      end

      def window_environmental_efficiency_rating
        xpath(%w[Windows Environmental-Efficiency-Rating])
      end

      def secondary_heating_description
        xpath(%w[Secondary-Heating Description])
      end

      def secondary_heating_energy_efficiency_rating
        xpath(%w[Secondary-Heating Energy-Efficiency-Rating])
      end

      def secondary_heating_environmental_efficiency_rating
        xpath(%w[Secondary-Heating Environmental-Efficiency-Rating])
      end

      def lighting_description
        xpath(%w[Lighting Description])
      end

      def lighting_energy_efficiency_rating
        xpath(%w[Lighting Energy-Efficiency-Rating])
      end

      def lighting_environmental_efficiency_rating
        xpath(%w[Lighting Environmental-Efficiency-Rating])
      end

      def built_form
        xpath(%w[Built-Form])
      end

      def wind_turbine_count
        @xml_doc.search("Wind-Turbines/Wind-Turbine").map(&:content).count
      end

      def all_main_heating_descriptions
        @xml_doc.search("Main-Heating/Description").map(&:content)
      end

      def all_main_heating_controls_descriptions
        @xml_doc.search("Main-Heating-Controls/Description").map(&:content)
      end

      def report_type
        xpath(%w[Report-Type])
      end

      def all_roof_descriptions
        @xml_doc.search("Roof/Description").map(&:content)
      end

      def all_roof_env_energy_efficiency_rating
        @xml_doc.search("Roof/Environmental-Efficiency-Rating").map(&:content)
      end

      def all_roof_energy_efficiency_rating
        @xml_doc.search("Roof/Environmental-Efficiency-Rating").map(&:content)
      end

      def all_wall_descriptions
        @xml_doc.search("Walls/Description").map(&:content)
      end

      def all_wall_energy_efficiency_rating
        @xml_doc.search("Walls/Energy-Efficiency-Rating").map(&:content)
      end

      def all_wall_env_energy_efficiency_rating
        @xml_doc.search("Walls/Environmental-Efficiency-Rating").map(&:content)
      end

      def energy_tariff
        xpath(%w[Electricity-Tariff])
      end

      def floor_level
        xpath(%w[SAP-Flat-Details Level])
      end

      def all_main_heating_energy_efficiency
        @xml_doc.search("Main-Heating/Energy-Efficiency-Rating").map(&:content)
      end

      def floor_height
        @xml_doc.search("Storey-Height").map(&:content)
      end

      def all_floor_descriptions
        @xml_doc.search("Property-Summary/Floor/Description").map(&:content)
      end

      def all_floor_energy_efficiency_rating
        @xml_doc
          .search("Property-Summary/Floor/Energy-Efficiency-Rating")
          .map(&:content)
      end

      def all_floor_env_energy_efficiency_rating
        @xml_doc
          .search("Property-Summary/Floor/Environmental-Efficiency-Rating")
          .map(&:content)
      end

      def all_main_heating_controls_energy_efficiency
        @xml_doc
          .search("Main-Heating-Controls/Energy-Efficiency-Rating")
          .map(&:content)
      end

      def all_main_heating_controls_environmental_efficiency
        @xml_doc
          .search("Main-Heating-Controls/Environmental-Efficiency-Rating")
          .map(&:content)
      end

      def all_main_heating_environmental_efficiency
        @xml_doc
          .search("Main-Heating/Environmental-Efficiency-Rating")
          .map(&:content)
      end

      def cylinder_insul_thickness
        xpath(%w[Hot-Water-Store-Insulation-Thickness])
      end

      def cylinder_insulation_type
        xpath(%w[Hot-Water-Store-Insulation-Type])
      end

      def cylinder_size
        xpath(%w[Hot-Water-Store-Size])
      end

      def has_cylinder_thermostat
        xpath(%w[Has-Cylinder-Thermostat])
      end

      def mech_vent_sys_index_number
        xpath(%w[Mechanical-Vent-System-Index-Number])&.to_i
      end

      def mechanical_vent_data_source
        xpath(%w[Mechanical-Ventilation-Data-Source])
      end

      def thermal_store
        xpath(%w[Thermal-Store])
      end

      def ventilation_type
        xpath(%w[Ventilation-Type])
      end

      def gas_smart_meter_present
        Helper::ToBool.execute(xpath(%w[Gas-Smart-Meter-Present]))
      end

      def electricity_smart_meter_present
        Helper::ToBool.execute(xpath(%w[Electricity-Smart-Meter-Present]))
      end
    end
  end
end
