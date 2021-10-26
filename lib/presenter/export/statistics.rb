module Presenter::Export
  class Statistics
    def initialize(wrapper)
      @wrapper = wrapper
      @view_model = wrapper.view_model
    end

    def build
      {
        current_energy_rating: current_energy_rating,
        transaction_type: @view_model.transaction_type,
      }
    rescue NoMethodError
      nil
    end

  private

    def current_energy_rating
      view_model_type = @view_model.class.to_s.split("::")[1].downcase

      if view_model_type.include?("sapschema")
        @view_model.current_energy_rating
      elsif view_model_type.include?("cepc")
        @view_model.energy_efficiency_rating
      end
    end
  end
end
