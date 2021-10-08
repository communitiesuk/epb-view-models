module Presenter
  class Xsd
    def get_enums_by_type(simple_type:, assessment_type:, xsd_dir_path: "api/schemas/xml/*/")
      xsd_files_gateway = ViewModelGateway::XsdFilesGateway.new(simple_type: simple_type, assessment_type: assessment_type, xsd_dir_path: xsd_dir_path)

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

class XsdFilesGateway
  attr_reader :simple_type, :assessment_type, :xsd_dir_path

  def initialize(simple_type:, assessment_type:, xsd_dir_path: "api/schemas/xml/*/")
    @simple_type = simple_type
    @assessment_type = assessment_type
    @xsd_dir_path = xsd_dir_path
  end

  def schema_version(file)
    schema_version = file.delete_prefix("api/schemas/xml/").split("/").first
    sap_defnied_in_rdsap_dir?(file) ? "#{schema_version}/SAP" : schema_version
  end

  def xsd_files
    files = case assessment_type
            when "SAP"
              sap_xsd_files
            when "RdSAP"
              rdsap_xsd_files
            when "CEPC"
              cepc_xsd_files
            end
    raise Boundary::XsdFilesNotFound, "No xsd files were found in #{xsd_dir_path} directory" if files.empty?

    files
  end

private

  def sap_defnied_in_rdsap_dir?(file)
    assessment_type == "SAP" && file.end_with?("SAP-Domains.xsd")
  end

  def sap_xsd_files
    Dir.glob("#{xsd_dir_path}*-Domains.xsd")
  end

  def rdsap_xsd_files
    Dir.glob("#{xsd_dir_path}SAP-Domains.xsd")
  end

  def cepc_xsd_files
    Dir.glob("#{xsd_dir_path}Reported-Data.xsd")
  end
end
