module ViewModel
  module CepcS71
    class Cepc < ViewModel::Cepc71::CommonSchema
      def date_of_expiry
        expires_at = (Date.parse(date_of_registration) - 1) >> 12 * 10

        expires_at.to_s
      end

      def building_environment
        xpath(%w[Building-Environment])
      end

      def energy_efficiency_rating
        xpath(%w[Asset-Rating])&.to_i
      end

      # def existing_build_rating
      #   xpath(%w[Existing-Stock-Benchmark])&.to_i
      # end

      def floor_area
        xpath(%w[Technical-Information Floor-Area])
      end

      def main_heating_fuel
        xpath(%w[Main-Heating-Fuel])
      end

      # def new_build_rating
      #   xpath(%w[New-Build-Benchmark])&.to_i
      # end

      # def primary_energy_use
      #   xpath(%w[Energy-Consumption-Current])
      # end

      def property_type
        xpath(%w[Property-Type])
      end

      def property_short_description
        xpath(%w[Property-Type Short-Description])
      end

      def compliant_2002
        xpath(%w[Compliant-2002])
      end

      def renewable_energy_sources
        @xml_doc.search("Renewable-Energy-Sources").map(&:content)
      end

      def electricity_sources
        @xml_doc.search("Electricity-Sources").map(&:content)
      end

      def primary_energy_indicator
      xpath(%w[Primary-Energy-Indicator])
      end

      def calculation_tool
      xpath(%w[Calculation-Tool])
      end

      def ter_2002
      xpath(%w[TER-2002])
      end

      def ter
        xpath(%w[TER])
      end

      def renewable_sources
        xpath(%w[Renewable-Sources])
      end

      def recommendations(payback = "")
        if payback.empty?
          # return an enumerable of all nodes
          @xml_doc.xpath "Recommendations-Report RR-Recommendations"
        else
          @xml_doc
            .search("Recommendations-Report RR-Recommendations/#{payback}")
            .map do |node|
            {
              code: node.at("Recommendation-Code").content,
              text: node.at("Recommendation").content,
              cO2Impact: node.at("CO2-Impact").content,
            }
          end
        end
      end

      def short_payback_recommendations
        recommendations("Short-Payback")
      end

      def medium_payback_recommendations
        recommendations("Medium-Payback")
      end

      def long_payback_recommendations
        recommendations("Long-Payback")
      end

      def other_recommendations
        recommendations("Other-Payback")
      end

      def related_rrn
        xpath(%w[Related-RRN])
      end

      def new_build_rating
        xpath(%w[New-Build-Benchmark])&.to_i
      end

      def existing_build_rating
        xpath(%w[Existing-Stock-Benchmark])&.to_i
      end

      def epc_related_party_disclosure
        xpath(%w[EPC-Related-Party-Disclosure])
      end
    end
  end
end
