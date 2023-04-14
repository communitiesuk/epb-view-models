require "singleton"

module Accessor
  class DomesticRecommendationsAccessor
    include Singleton

    RecommendationDetails = Struct.new(:summary, :description, keyword_init: true)

    def fetch_details(schema_version:, improvement_number:)
      unless memoized_schema?(schema_version)
        assessment_type = schema_version.split("-").first
        is_ni = schema_version.include? "-NI-"
        definitions_document = Nokogiri::XML(File.open("api/schemas/xml/#{schema_version}/#{assessment_type}/ExternalDefinitions.xml"))
        sub_object = {}
        country_node = definitions_document.at_xpath("//Country[Country-Code[contains(text(), '#{is_ni ? 'NIR' : 'EAW'}')]]")
        recommendations = country_node.search("Recommendation")
        recommendations.each do |recommendation|
          sub_object[recommendation.at_css("Improvement-Number").content] = {
            summary: recommendation.at_css("Improvement-Summary[language='1']").content,
            description: recommendation.at_css("Improvement-Description[language='1']").content,
          }
        end
        memoize_schema_hash(schema_version, sub_object)
      end
      RecommendationDetails.new(**memoized_schema(schema_version)[improvement_number])
    end

    def reset!
      @memo = nil
    end

  private

    def memo
      @memo ||= {}
    end

    def memoized_schema?(schema_version)
      memo.key?(schema_version)
    end

    def memoize_schema_hash(schema_version, hash)
      memo[schema_version] = hash
    end

    def memoized_schema(schema_version)
      memo[schema_version]
    end
  end
end
