module ViewModelDomain
  class XsdArguments
    attr_reader :simple_type, :assessment_type, :xsd_dir_path, :gem_path

    def initialize(simple_type:, assessment_type:, xsd_dir_path: "/api/schemas/xml/**/", gem_path: "")
      @simple_type = simple_type
      @assessment_type = assessment_type
      @xsd_dir_path = xsd_dir_path
      @gem_path = gem_path
    end
  end
end
