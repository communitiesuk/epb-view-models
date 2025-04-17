module Presenter
  module RdSap
    class DomesticDigest
      TYPE_OF_ASSESSMENT = "RdSAP".freeze
      private_constant :TYPE_OF_ASSESSMENT

      def initialize(view_model, schema_type)
        @view_model = view_model
        @schema_type = schema_type
      end

      def to_domestic_digest
        {
          type_of_assessment: TYPE_OF_ASSESSMENT,
          assessment_id: @view_model.assessment_id,
          date_of_registration: @view_model.date_of_registration,
          address: {
            address_line1: @view_model.address_line1,
            address_line2: @view_model.address_line2,
            address_line3: @view_model.address_line3,
            address_line4: @view_model.address_line4,
            town: @view_model.town,
            postcode: @view_model.postcode,
          },
          dwelling_type: @view_model.dwelling_type,
          built_form: Helper::XmlEnumsToOutput.built_form_string(@view_model.built_form),
          main_dwelling_construction_age_band_or_year: Helper::XmlEnumsToOutput.construction_age_band_lookup(
            @view_model.main_dwelling_construction_age_band_or_year,
            @schema_type,
            @view_model.report_type,
          ),
          property_summary: @view_model.property_summary,
          main_heating_category: Helper::XmlEnumsToOutput.main_heating_category(value: @view_model.main_heating_category),
          main_fuel_type: Helper::XmlEnumsToOutput.fuel_type(@view_model.main_fuel_type,
                                                             @schema_type,
                                                             @view_model.report_type),
          has_hot_water_cylinder: @view_model.has_hot_water_cylinder,
          total_floor_area: @view_model.total_floor_area.to_s,
          has_mains_gas: @view_model.respond_to?(:mains_gas) ? @view_model.mains_gas : nil,
          current_energy_efficiency_rating: @view_model.current_energy_rating,
          potential_energy_efficiency_rating: @view_model.potential_energy_rating,
          type_of_property: Helper::XmlEnumsToOutput.property_type(@view_model.property_type),
          recommended_improvements: @view_model.improvements.map do |improvement|
            improvement[:energy_performance_band_improvement] =
              Helper::EnergyBandCalculator.domestic(improvement[:energy_performance_rating_improvement])
            improvement
          end,
          photo_supply: @view_model.respond_to?(:photovoltaic_roof_area_percent) && !@view_model.photovoltaic_roof_area_percent.nil? ? @view_model.photovoltaic_roof_area_percent.to_i : nil,
          main_heating_controls: @view_model.all_main_heating_controls_descriptions,
          lzc_energy_sources: @view_model.respond_to?(:lzc_energy_sources) ? @view_model.lzc_energy_sources : nil,
        }
      end
    end
  end
end
