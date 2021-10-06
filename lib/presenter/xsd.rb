module Presenter
  class Xsd
    def initialize(assessment_type:, xsd_dir_path: "api/schemas/xml/*/")
      @assessment_type = assessment_type
      @xsd_dir_path = xsd_dir_path
    end

    def get_enums_by_type(simple_type)
      hash = {}
      xpath = "//xs:simpleType[@name='#{simple_type}']//xs:enumeration"
      xsd_files.each do |file_name|
        doc = REXML::Document.new(File.read(file_name))
        enums_hash = {}
        REXML::XPath.each(doc, "#{xpath}/@value") do |e|
          desc_path = "#{xpath}[@value='#{e.value}']//xs:annotation//xs:documentation"
          enums_hash.merge!(e.value => REXML::XPath.first(doc, desc_path).children.first)
        end

        next if enums_hash.empty?

        hash[schema_version(file_name)] = enums_hash
      end
      hash
    end

  private

    def schema_version(file_name)
      schema_version = file_name.delete_prefix("api/schemas/xml/").split("/").first
      sap_defnied_in_rdsap_dir?(file_name) ? "#{schema_version}/SAP" : schema_version
    end

    def xsd_files
      case @assessment_type
      when "SAP"
        sap_xsd_files
      when "RdSAP"
        rdsap_xsd_files
      end
    end

    def sap_xsd_files
      Dir.glob("#{@xsd_dir_path}*-Domains.xsd")
    end

    def rdsap_xsd_files
      Dir.glob("#{@xsd_dir_path}SAP-Domains.xsd")
    end

    def cepc_xsd_files
      Dir.glob("#{@xsd_dir_path}Reported-Data.xsd")
    end

    def sap_defnied_in_rdsap_dir?(file_name)
      @assessment_type == "SAP" && file_name.end_with?("SAP-Domains.xsd")
    end
  end
end
