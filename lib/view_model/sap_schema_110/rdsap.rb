module ViewModel
  module SapSchema110
    class Rdsap < ViewModel::SapSchema110::CommonSchema
      def property_age_band
        nil
      end

      # DO NOT CORRECT - this typo is present in the schema XML pre 12.0
      def mechanical_ventilation
        xpath(%w[Mechanical-Ventliation])
      end

      def main_dwelling_construction_age_band_or_year
        sap_building_parts =
          @xml_doc.xpath("//SAP-Building-Parts/SAP-Building-Part")
        sap_building_parts.each do |sap_building_part|
          identifier = sap_building_part.at("Identifier")
          if identifier&.content == "Main Dwelling"
            return(
              sap_building_part.at_xpath(
                "Construction-Age-Band | Construction-Year",
              )&.content
            )
          end
        end
        nil
      end

      def glazed_area
        xpath(%w[Glazed-Area])
      end

      def window_description
        xpath(%w[Window Description])
      end

      def window_energy_efficiency_rating
        xpath(%w[Window Energy-Efficiency-Rating])
      end

      def window_environmental_efficiency_rating
        xpath(%w[Window Environmental-Efficiency-Rating])
      end

      def all_wall_descriptions
        @xml_doc.search("Wall/Description").map(&:content)
      end

      def all_wall_energy_efficiency_rating
        @xml_doc.search("Wall/Energy-Efficiency-Rating").map(&:content)
      end

      def all_wall_env_energy_efficiency_rating
        @xml_doc.search("Wall/Environmental-Efficiency-Rating").map(&:content)
      end

      def habitable_room_count
        xpath(%w[Habitable-Room-Count])&.to_i
      end

      def heated_room_count
        xpath(%w[Heated-Room-Count])&.to_i
      end

      def photovoltaic_roof_area_percent
        xpath(%w[Photovoltaic-Supply])
      end

      def solar_water_heating_flag
        xpath(%w[Solar-Water-Heating])
      end

      def floor_height
        @xml_doc.search("Room-Height").map(&:content)
      end

      def storey_count
        xpath(%w[Storey-Count])&.to_i
      end

      def energy_tariff
        xpath(%w[Meter-Type])
      end

      def cylinder_insul_thickness
        xpath(%w[Cylinder-Insulation-Thickness])
      end

      def cylinder_insulation_type
        xpath(%w[Cylinder-Insulation-Type])
      end

      def cylinder_size
        xpath(%w[Cylinder-Size])
      end

      def has_cylinder_thermostat
        xpath(%w[Cylinder-Thermostat])
      end

      def water_heating_fuel
        xpath(%w[Water-Heating-Fuel])
      end
    end
  end
end
