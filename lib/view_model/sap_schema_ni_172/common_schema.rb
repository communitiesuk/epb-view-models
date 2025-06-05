module ViewModel
  module SapSchemaNi172
    class CommonSchema < ViewModel::DomesticEpcViewModel
      def assessment_id
        xpath(%w[RRN])
      end

      def address_line1
        xpath(%w[Property Address Address-Line-1])
      end

      def address_line2
        xpath(%w[Property Address Address-Line-2]).to_s
      end

      def address_line3
        xpath(%w[Property Address Address-Line-3]).to_s
      end

      def address_line4
        xpath(%w[Property Address Address-Line-4]).to_s
      end

      def town
        xpath(%w[Property Address Post-Town])
      end

      def postcode
        xpath(%w[Property Address Postcode])
      end

      def scheme_assessor_id
        xpath(%w[Certificate-Number])
      end

      def assessor_name
        [
          xpath(%w[Home-Inspector Name Prefix]),
          xpath(%w[Home-Inspector Name First-Name]),
          xpath(%w[Home-Inspector Name Surname]),
          xpath(%w[Home-Inspector Name Suffix]),
        ].reject { |e| e.to_s.empty? }.join(" ")
      end

      def assessor_email
        xpath(%w[Home-Inspector E-Mail])
      end

      def assessor_telephone
        xpath(%w[Home-Inspector Telephone])
      end

      def date_of_assessment
        xpath(%w[Inspection-Date])
      end

      def date_of_registration
        xpath(%w[Registration-Date])
      end

      def address_id
        "LPRN-#{xpath(%w[UPRN])}"
      end

      def all_main_heating_descriptions
        @xml_doc.search("Main-Heating/Description").map(&:content)
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
        xpath(%w[Property-Summary Total-Floor-Area])
      end

      def dwelling_type
        xpath(%w[Dwelling-Type])
      end

      def potential_energy_saving; end

      def property_age_band
        xpath(%w[Construction-Year])
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

      def country_code
        xpath(%w[Country-Code])
      end

      def main_fuel_type
        xpath(%w[Main-Fuel-Type])
      end

      def secondary_fuel_type
        xpath(%w[Secondary-Fuel-Type])
      end

      def type_of_assessment
        case xpath(%w[Report-Type])&.to_i
        when 1
          "HCR"
        when 2
          "RdSAP"
        when 3
          "SAP"
        end
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

      def level
        xpath(%w[Level])
      end

      def top_storey
        flat_level_code = xpath(%w[Level])
        flat_level_code == "3" ? "Y" : "N"
      end

      def main_heating_controls
        xpath(%w[Main-Heating-Controls Description])
      end

      def multiple_glazed_proportion
        xpath(%w[Multiple-Glazed-Proportion])
      end

      def low_energy_lighting
        xpath(%w[Low-Energy-Fixed-Lighting-Outlets-Percentage])
      end

      def fixed_lighting_outlets_count
        xpath(%w[Fixed-Lighting-Outlets-Count])&.to_i
      end

      def low_energy_fixed_lighting_outlets_count
        xpath(%w[Low-Energy-Fixed-Lighting-Outlets-Count])&.to_i
      end

      def open_fireplaces_count
        xpath(%w[Open-Fireplaces-Count])&.to_i
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
        xpath(%w[Wind-Turbines-Count])&.to_i
      end

      def heat_loss_corridor
        xpath(%w[Heat-Loss-Corridor])
      end

      def unheated_corridor_length
        xpath(%w[Unheated-Corridor-Length])
      end

      def extensions_count
        xpath(%w[Extensions-Count])&.to_i
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

      def all_roof_energy_efficiency_rating
        @xml_doc.search("Roof/Energy-Efficiency-Rating").map(&:content)
      end

      def all_roof_env_energy_efficiency_rating
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

      def all_main_heating_environmental_efficiency
        @xml_doc
          .search("Main-Heating/Environmental-Efficiency-Rating")
          .map(&:content)
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
    end
  end
end
