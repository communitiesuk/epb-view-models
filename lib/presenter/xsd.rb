module Presenter
  class Xsd
    attr_reader :xsd_dir_path

    def initialize(xsd_dir_path: "api/schemas/xml/**/*-Domains.xsd")
      @xsd_dir_path = xsd_dir_path
    end

    def get_enums_by_type(simple_type)
      hash = {}
      xpath = "//xs:simpleType[@name='#{simple_type}']//xs:enumeration"

      xsd_files(xsd_dir_path).each do |file_name|
        doc = REXML::Document.new(File.read(file_name))
        enums_hash = {}
        REXML::XPath.each(doc, "#{xpath}/@value") do |e|
          desc_path = "#{xpath}[@value='#{e.value}']//xs:annotation//xs:documentation"
          enums_hash.merge!(e.value => REXML::XPath.first(doc, desc_path).children.first)
        end

        schema_version = schema_version(file_name)
        enums_for_schema_version = { schema_version => enums_hash }

        hash.merge!(enums_for_schema_version)
      end
      hash
    end

  private

    def schema_version(file_name)
      file_name.delete_prefix("api/schemas/xml/")
      # need some custom logic for SAP-Schema-10.2 - SAP-Schema-18.0.0
      # if includes("EPC-Domains")
    end

    def xsd_files(xsd_dir_path)
      Dir.glob(xsd_dir_path)
    end
  end
end
