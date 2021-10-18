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

      xsd_files.each do |file|
        enums_hash = File.extname(file).downcase == ".xsd" ? read_xsd(file, domain_arguments.simple_type) : read_xml(file, domain_arguments.simple_type, domain_arguments.node_hash)

        next if enums_hash.empty?

        hash[xsd_files_gateway.schema_version(file)] = enums_hash
      end

      raise ViewModelBoundary::NodeNotFound, "Node #{domain_arguments.simple_type} was not found in any of the files in #{domain_arguments.xsd_dir_path} directory" if hash.empty?

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

  private

    def read_xsd(file_name, simple_type)
      xpath = "//xs:simpleType[@name='#{simple_type}']//xs:enumeration"
      doc = REXML::Document.new(File.read(file_name))
      enums_hash = {}
      REXML::XPath.each(doc, "#{xpath}/@value") do |node|
        desc_path = "#{xpath}[@value='#{node.value}']//xs:annotation//xs:documentation"
        enums_hash.merge!(node.value => REXML::XPath.first(doc, desc_path).children.first)
      end
      enums_hash
    end

    def read_xml(file_name, node_name, node_hash)
      doc = Nokogiri.XML(File.read(file_name))
      enums_hash = {}

      doc.xpath(node_name).each do |node|

        enums_hash.merge!(node.xpath(node_hash.keys[0].to_s).children.text => node.xpath(node_hash.values[0]).children.text)
      end

      enums_hash
    end
  end
end
