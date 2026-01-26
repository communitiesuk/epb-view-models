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

      def current_energy_efficiency_band
        xpath(%w[Energy-Band])
      end

      def potential_energy_rating
        xpath(%w[Potential-Rating])
      end

      def potential_energy_band
        xpath(%w[Potential-Band])
      end

      def new_build_benchmark_rating
        xpath(%w[New-Build-Benchmark])
      end

      def new_build_benchmark_band
        xpath(%w[New-Build-Benchmark-Band])
      end

      def comparative_asset_rating
        xpath(%w[Comparative-Asset-Rating])
      end

      def comparative_asset_band
        xpath(%w[Comparative-Energy-Band])
      end

      def epc_rating_ber
        xpath(%w[BER])
      end

      def approximate_energy_use
        xpath(%w[Approximate-Energy-Use])
      end

      def floor_area
        xpath(%w[Technical-Information Floor-Area])
      end

      def main_heating_fuel
        xpath(%w[Main-Heating-Fuel])
      end

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

      def trading_address
        xpath(%w[Trading-Address])
      end

      def company_name
        xpath(%w[Company-Name])
      end

      def insurer
        xpath(%w[Insurer])
      end

      def policy_no
        xpath(%w[Policy-No])
      end

      def insurer_effective_date
        xpath(%w[Effective-Date])
      end

      def insurer_expiry_date
        xpath(%w[Expiry-Date])
      end

      def insurer_pi_limit
        xpath(%w[PI-Limit])
      end
    end
  end
end
