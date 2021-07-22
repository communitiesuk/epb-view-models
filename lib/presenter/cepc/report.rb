module Presenter
  module Cepc
    class Report
      TYPE_OF_ASSESSMENT = "CEPC".freeze

      def initialize(view_model, additional_data)
        @view_model = view_model
        @additional_data = additional_data
      end

      def to_hash
        report_from_assessment_xml
          .merge(report_from_additional_data)
      end

    private

      def report_from_assessment_xml
        {
          assessment_id: @view_model.assessment_id,
          ac_inspection_commissioned: @view_model.ac_inspection_commissioned,
          address1: @view_model.address_line1,
          address2: @view_model.address_line2,
          address3: @view_model.address_line3,
          aircon_kw_rating: @view_model.ac_kw_rating,
          aircon_present:
            if !@view_model.ac_present.nil? &&
                @view_model.ac_present.upcase == "YES"
              "Y"
            else
              "N"
            end,
          asset_rating: @view_model.energy_efficiency_rating,
          asset_rating_band:
            Helper::EnergyBandCalculator.commercial(
              @view_model.energy_efficiency_rating.to_i,
            ),
          building_emissions: @view_model.building_emission_rate,
          building_environment: @view_model.building_environment,
          building_level: @view_model.building_level,
          estimated_aircon_kw_rating: @view_model.estimated_ac_kw_rating,
          existing_stock_benchmark: @view_model.existing_build_rating,
          floor_area: @view_model.floor_area,
          inspection_date: @view_model.date_of_assessment,
          lodgement_date: @view_model.date_of_registration,
          main_heating_fuel: @view_model.main_heating_fuel,
          new_build_benchmark: @view_model.new_build_rating,
          other_fuel_desc: @view_model.other_fuel_description,
          postcode: @view_model.postcode,
          posttown: @view_model.town,
          primary_energy_value: @view_model.primary_energy_use,
          property_type: @view_model.property_type,
          report_type: @view_model.report_type,
          special_energy_uses: @view_model.special_energy_uses,
          standard_emissions: @view_model.standard_emissions,
          target_emissions: @view_model.target_emissions,
          transaction_type:
            Helper::XmlEnumsToOutput.cepc_transaction_type(
              @view_model.transaction_type,
            ),
          type_of_assessment: TYPE_OF_ASSESSMENT,
          typical_emissions: @view_model.typical_emissions,
          renewable_sources: @view_model.renewable_sources,
        }
      end

      def report_from_additional_data
        report = {}

        if @additional_data.key?(:address_id)
          report[:building_reference_number] = @additional_data[:address_id]
        end

        report
      end
    end
  end
end
