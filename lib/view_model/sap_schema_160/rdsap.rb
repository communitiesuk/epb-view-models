module ViewModel
  module SapSchema160
    class Rdsap < ViewModel::SapSchema160::CommonSchema
      def assessor_name
        xpath(%w[Home-Inspector Name])
      end

      def property_age_band
        xpath(%w[Construction-Age-Band])
      end

      def mechanical_ventilation
        xpath(%w[Mechanical-Ventilation])
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

      def glazed_area
        xpath(%w[Glazed-Area])
      end

      def habitable_room_count
        xpath(%w[Habitable-Room-Count])&.to_i
      end

      def heated_room_count
        xpath(%w[Heated-Room-Count])&.to_i
      end

      def photovoltaic_roof_area_percent
        xpath(%w[Photovoltaic-Supply Percent-Roof-Area])
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
