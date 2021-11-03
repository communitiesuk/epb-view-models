module Presenter::Export
  class Statistics
    def initialize(wrapper)
      @wrapper = wrapper
      @view_model = wrapper.view_model
    end

    def build
      {
        transaction_type: @view_model.transaction_type,
      }
    rescue NoMethodError
      {
        transaction_type: 0,
      }
    end
  end
end
