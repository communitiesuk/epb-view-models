module Presenter
  class Xsd
    def get_enums_by_type(simple_type:, assessment_type:, xsd_dir_path: "api/schemas/xml/*/")
      xsd_files_gateway = Gateway::XsdFilesGateway.new(simple_type: simple_type, assessment_type: assessment_type, xsd_dir_path: xsd_dir_path)

      begin
        xsd_files = xsd_files_gateway.xsd_files
      rescue Boundary::XsdFilesNotFound => e
        raise Boundary::XsdFilesNotFound, e.message.to_s
      end

      hash = {}
      xpath = "//xs:simpleType[@name='#{simple_type}']//xs:enumeration"

      xsd_files.each do |file|
        doc = REXML::Document.new(File.read(file))
        enums_hash = {}
        REXML::XPath.each(doc, "#{xpath}/@value") do |node|
          desc_path = "#{xpath}[@value='#{node.value}']//xs:annotation//xs:documentation"
          enums_hash.merge!(node.value => REXML::XPath.first(doc, desc_path).children.first)
        end

        next if enums_hash.empty?

        hash[xsd_files_gateway.schema_version(file)] = enums_hash
      end

      raise Boundary::NodeNotFound, "Node #{simple_type} was not found in any of the xsd files in #{xsd_dir_path} directory" if hash.empty?

      hash
    end

    def unique_enums(simple_type:, assessment_type:, xsd_dir_path: "api/schemas/xml/*/")
      uniq_enums = []
      enums = get_enums_by_type(simple_type: simple_type, assessment_type: assessment_type, xsd_dir_path: xsd_dir_path).values

      enums.each_with_index do |_hash, i|
        if i.positive? && (enums[i].to_a != enums[i + 1].to_a)
          uniq_enums << enums[i]
        end
      end
      uniq_enums
    end

    def variation_between_schema_versions?(enums_hash)
      enums_hash.values.flatten.uniq.count != 1
    end
  end
end
