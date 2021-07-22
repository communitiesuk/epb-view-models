module Presenter
  module DecRr
    class RecommendationReport
      def initialize(view_model)
        @view_model = view_model
      end

      def to_hash
        {
          assessment_id: @view_model.assessment_id,
          recommendations: [
            @view_model.short_payback_recommendations.map do |recommendation|
              {
                payback_type: "short",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
            @view_model.medium_payback_recommendations.map do |recommendation|
              {
                payback_type: "medium",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
            @view_model.long_payback_recommendations.map do |recommendation|
              {
                payback_type: "long",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
            @view_model.other_recommendations.map do |recommendation|
              {
                payback_type: "other",
                recommendation_code: recommendation[:code],
                recommendation: recommendation[:text],
                cO2_Impact: recommendation[:cO2Impact],
              }
            end,
          ].flatten,
        }
      end
    end
  end
end
