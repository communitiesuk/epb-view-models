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
    end

  private

    def current_energy_rating
      @view_model.current_energy_rating
    rescue NoMethodError
      @view_model.energy_efficiency_rating
    end
  end
end
