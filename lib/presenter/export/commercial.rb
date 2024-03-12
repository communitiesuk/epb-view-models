module Presenter::Export
  class Commercial < Presenter::Export::Base
    def build
      view = {}
      view[:assessment_id] = @view_model.assessment_id
      view[:type_of_assessment] = @wrapper.type.to_s
      view[:address] = address
      view[:assessor] = assessor
      view[:building_emission_rate] = @view_model.respond_to?(:building_emission_rate) ? @view_model.building_emission_rate : nil
      view[:date_of_expiry] = @view_model.date_of_expiry
      view[:report_type] = @view_model.report_type
      view[:date_of_assessment] = @view_model.date_of_assessment
      view[:date_of_registration] = @view_model.date_of_registration
      view[:technical_information] = {
        main_heating_fuel: @view_model.main_heating_fuel,
        building_environment: @view_model.building_environment,
        floor_area: @view_model.floor_area,
        building_level: @view_model.building_level,
      }
      view[:primary_energy_use] = @view_model.respond_to?(:primary_energy_use) ? @view_model.primary_energy_use : nil
      view[:related_rrn] = @view_model.related_rrn
      view[:new_build_rating] = @view_model.new_build_rating
      view[:related_party_disclosure] = @view_model.epc_related_party_disclosure
      view[:property_type] = @view_model.property_type
      view[:building_complexity] = @view_model.building_level
      view[:energy_efficiency_rating] = @view_model.energy_efficiency_rating
      view[:current_energy_efficiency_rating] =
        @view_model.energy_efficiency_rating
      view[:current_energy_efficiency_band] =
        Helper::EnergyBandCalculator.commercial(@view_model.energy_efficiency_rating)
      view[:new_build_band] =
        Helper::EnergyBandCalculator.commercial(@view_model.new_build_rating)
      view[:existing_build_rating] = @view_model.existing_build_rating
      view[:existing_build_band] =
        Helper::EnergyBandCalculator.commercial(@view_model.existing_build_rating)
      view[:ac_inspection_commissioned] = @view_model.respond_to?(:ac_inspection_commissioned) ? @view_model.ac_inspection_commissioned : nil
      view[:aircon_kw_rating] = @view_model.respond_to?(:ac_kw_rating) ? @view_model.ac_kw_rating : nil
      view[:aircon_present] = @view_model.ac_present if @view_model.respond_to?(:ac_present)
      view[:asset_rating] = @view_model.energy_efficiency_rating
      view[:asset_rating_band] =
        Helper::EnergyBandCalculator.commercial(@view_model.energy_efficiency_rating)
      view[:building_environment] = @view_model.building_environment
      view[:building_level] = @view_model.building_level
      view[:building_reference_number] = @view_model.address_id
      view[:estimated_aircon_kw_rating] = @view_model.respond_to?(:estimated_ac_kw_rating) ? @view_model.estimated_ac_kw_rating : nil
      view[:existing_stock_benchmark] = @view_model.existing_build_rating
      view[:floor_area] = @view_model.floor_area
      view[:main_heating_fuel] = @view_model.main_heating_fuel
      view[:other_fuel_description] = @view_model.other_fuel_description
      view[:special_energy_uses] = @view_model.special_energy_uses
      view[:standard_emissions] = @view_model.respond_to?(:standard_emissions) ? @view_model.standard_emissions : nil
      view[:target_emissions] = @view_model.respond_to?(:target_emissions) ? @view_model.target_emissions : nil
      view[:transaction_type] =
        enum_value(:transaction_type, @view_model.respond_to?(:transaction_type) ? @view_model.transaction_type : nil)
      view[:typical_emissions] = @view_model.respond_to?(:typical_emissions) ? @view_model.typical_emissions : nil
      view[:renewable_sources] = @view_model.renewable_sources
      view[:metadata] = metadata

      view
    end
  end
end
