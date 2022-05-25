module Presenter
  module RdSap
    class Hera
      TYPE_OF_ASSESSMENT = "RdSAP".freeze
      private_constant :TYPE_OF_ASSESSMENT

      def initialize(view_model)
        @view_model = view_model
      end

      def to_hera_hash
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
          built_form: @view_model.built_form,
          main_dwelling_construction_age_band_or_year: @view_model.main_dwelling_construction_age_band_or_year,
          property_summary: @view_model.property_summary,
          main_heating_category: @view_model.main_heating_category,
          main_fuel_type: @view_model.main_fuel_type,
          has_hot_water_cylinder: @view_model.has_hot_water_cylinder,
        }
      end
    end
  end
end
