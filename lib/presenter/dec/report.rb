module Presenter
  module Dec
    class Report
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
          address1: @view_model.address_line1,
          address2: @view_model.address_line2,
          address3: @view_model.address_line3,
          posttown: @view_model.town,
          postcode: @view_model.postcode,
          current_operational_rating: @view_model.energy_efficiency_rating,
          yr1_operational_rating: @view_model.year1_energy_efficiency_rating,
          yr2_operational_rating: @view_model.year2_energy_efficiency_rating,
          operational_rating_band:
            Helper::EnergyBandCalculator.commercial(
              @view_model.energy_efficiency_rating.to_i,
            ).upcase,
          electric_co2: @view_model.current_electricity_co2,
          heating_co2: @view_model.current_heating_co2,
          renewables_co2: @view_model.current_renewables_co2,
          property_type: @view_model.property_type,
          inspection_date: @view_model.date_of_assessment,
          nominated_date: @view_model.current_assessment_date,
          or_assessment_end_date: @view_model.or_assessment_end_date,
          lodgement_date: @view_model.date_of_registration,
          lodgement_datetime: "",
          main_benchmark: @view_model.main_benchmark,
          main_heating_fuel: @view_model.main_heating_fuel,
          special_energy_uses: @view_model.special_energy_uses,
          renewable_sources: @view_model.renewables_fuel_thermal,
          total_floor_area: @view_model.floor_area,
          occupancy_level: @view_model.occupancy_level,
          annual_thermal_fuel_usage: @view_model.annual_energy_use_fuel_thermal,
          typical_thermal_fuel_usage: @view_model.typical_thermal_use,
          annual_electrical_fuel_usage: @view_model.annual_energy_use_electrical,
          typical_electrical_fuel_usage: @view_model.typical_electrical_use,
          renewables_fuel_thermal: @view_model.renewables_fuel_thermal,
          renewables_electrical: @view_model.renewables_electrical,
          yr1_electricity_co2: @view_model.year1_electricity_co2,
          yr2_electricity_co2: @view_model.year2_electricity_co2,
          yr1_heating_co2: @view_model.year1_heating_co2,
          yr2_heating_co2: @view_model.year2_heating_co2,
          yr1_renewables_co2: @view_model.year1_renewables_co2,
          yr2_renewables_co2: @view_model.year2_renewables_co2,
          # open data request for return value to be Y OR N
          aircon_present:
            if !@view_model.ac_present.nil? &&
                @view_model.ac_present.upcase == "YES"
              "Y"
            else
              "N"
            end,
          aircon_kw_rating: @view_model.ac_kw_rating,
          estimated_aircon_kw_rating: @view_model.estimated_ac_kw_rating,
          ac_inspection_commissioned: @view_model.ac_inspection_commissioned,
          building_environment: @view_model.building_environment,
          building_category: @view_model.building_category,
          report_type: @view_model.report_type,
          other_fuel: @view_model.other_fuel,
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
