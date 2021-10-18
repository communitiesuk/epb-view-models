module ViewModelDomain
  class XsdArguments
    attr_reader :simple_type, :assessment_type, :xsd_dir_path, :gem_path, :node_hash

    def initialize(simple_type:, assessment_type:, xsd_dir_path: "", gem_path: "", node_hash: nil)
      @simple_type = simple_type
      @assessment_type = assessment_type
      @xsd_dir_path = xsd_dir_path
      @gem_path = gem_path
      @node_hash = node_hash
    end
  end
end
