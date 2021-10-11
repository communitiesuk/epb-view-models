module Presenter
  class Xsd
    def get_enums_by_type(domain_arguments)
      xsd_files_gateway = ViewModelGateway::XsdFilesGateway.new(domain_arguments)

      begin
        xsd_files = xsd_files_gateway.xsd_files
      rescue ViewModelBoundary::XsdFilesNotFound => e
        raise ViewModelBoundary::XsdFilesNotFound, e.message.to_s
      end

      hash = {}
      xpath = "//xs:simpleType[@name='#{domain_arguments.simple_type}']//xs:enumeration"

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

      raise ViewModelBoundary::NodeNotFound, "Node #{domain_arguments.simple_type} was not found in any of the xsd files in #{domain_arguments.xsd_dir_path} directory" if hash.empty?

      hash
    end

    def unique_enums(domain_arguments)
      uniq_enums = []
      enums = get_enums_by_type(domain_arguments).values

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
