require "active_support"
require "active_support/core_ext/time/conversions"

module Presenter::Export
  class Base
    REDACTED = "REDACTED".freeze
    private_constant :REDACTED

    def initialize(wrapper, assessment)
      @wrapper = wrapper
      @view_model = wrapper.view_model
      @assessment = assessment
    end

    def address
      {
        address_id: @view_model.address_id,
        address_line1: @view_model.address_line1,
        address_line2: @view_model.address_line2,
        address_line3: @view_model.address_line3,
        address_line4:
          if @view_model.respond_to?(:address_line4)
            @view_model.address_line4
          end,
        postcode: @view_model.postcode,
        town: @view_model.town,
      }
    end

    def assessor
      {
        "scheme_assessor_id": REDACTED, # @view_model.scheme_assessor_id,
        "name": REDACTED, # @view_model.assessor_name,
        "email": REDACTED, # @view_model.assessor_email,
        "telephone": REDACTED, # @view_model.assessor_telephone,
      }
    end

    def heat_demand
      {
        current_space_heating_demand:
          @view_model.current_space_heating_demand&.to_i,
        current_water_heating_demand:
          @view_model.current_water_heating_demand&.to_i,
        impact_of_cavity_insulation: @view_model.impact_of_cavity_insulation,
        impact_of_loft_insulation: @view_model.impact_of_loft_insulation,
        impact_of_solid_wall_insulation:
          @view_model.impact_of_solid_wall_insulation,
      }
    end

    def enum_value(method, *value)
      {
        description: Helper::XmlEnumsToOutput.send(method, *value),
        value: value[0],
      }
    end

    def metadata
      metadata = {}
      metadata[:address_id] = @assessment.get(:address_id)
      metadata[:created_at] =
        if @assessment.get(:created_at).nil?
          Time.new(2020, 9, 27, 8, 30).to_formatted_s(:iso8601)
        else
          Time
            .parse(@assessment.get(:created_at).to_s)
            .to_formatted_s(:iso8601)
        end
      metadata[:opt_out] = @assessment.get(:opt_out)
      metadata[:cancelled_at] = @assessment.get(:cancelled_at)
      metadata[:not_for_issue_at] = @assessment.get(:not_for_issue_at)
      metadata
    end
  end
end
