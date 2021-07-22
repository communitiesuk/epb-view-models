module Presenter
  module Sap
    class RecommendationReport
      def initialize(view_model)
        @view_model = view_model
      end

      def to_hash
        complete_recommendations =
          @view_model.recommendations_for_report.each do |recommendations|
            recommendations[:assessment_id] = @view_model.assessment_id
          end

        { recommendations: complete_recommendations }
      end
    end
  end
end
