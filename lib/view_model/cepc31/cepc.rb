module ViewModel
  module Cepc31
    class Cepc < ViewModel::Cepc31::CommonSchema
      def building_environment
        xpath(%w[Building-Environment])
      end

      def building_level
        xpath(%w[Building-Level])&.to_i
      end

      def energy_efficiency_rating
        xpath(%w[Asset-Rating])&.to_i
      end

      def epc_related_party_disclosure
        xpath(%w[Related-Party-Disclosure])
      end

      def existing_build_rating
        xpath(%w[Existing-Stock-Benchmark])
      end

      def floor_area
        xpath(%w[Technical-Information Floor-Area])
      end

      def main_heating_fuel
        xpath(%w[Main-Heating-Fuel])
      end

      def new_build_rating
        xpath(%w[New-Build-Benchmark])
      end

      def other_fuel_description
        xpath(%w[Other-Fuel-Description])
      end

      def primary_energy_use
        xpath(%w[Energy-Consumption-Current])
      end

      def property_type
        xpath(%w[Property-Type])
      end

      def related_rrn
        xpath(%w[Related-RRN])
      end

      def special_energy_uses
        xpath(%w[Special-Energy-Uses])
      end

      def renewable_sources
        xpath(%w[Renewable-Sources])
      end
    end
  end
end
