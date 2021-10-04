module Presenter
  class Xsd
    def initialize(xsd_dir_path: "api/schemas/xml/**/*-Domains.xsd")
      # @schema_type = schema_type
      @xsd_files = get_files(xsd_dir_path)
    end


    def get_enums_by_type(simple_type)
      arr = []
      xpath = "//xs:simpleType[@name='#{simple_type}']//xs:enumeration"
      @xsd_files.each do |file_name|
        doc = REXML::Document.new(File.read(file_name))
        hash = {}
        REXML::XPath.each(doc, "#{xpath}/@value") do |e|
          desc_path = "#{xpath}[@value='#{e.value}']//xs:annotation//xs:documentation"
          hash.merge!(e.value => REXML::XPath.first(doc, desc_path).children.first)
        end
        arr << hash
      end
      arr
    end

    private
    def get_files(xsd_dir_path)
      Dir.glob(xsd_dir_path)
    end
  end
end