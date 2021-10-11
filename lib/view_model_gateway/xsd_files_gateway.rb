module ViewModelGateway
  class XsdFilesGateway
    attr_reader :simple_type, :assessment_type, :xsd_dir_path

    def initialize(simple_type:, assessment_type:, xsd_dir_path: "/api/schemas/xml/*/")
      @simple_type = simple_type
      @assessment_type = assessment_type
      @xsd_dir_path = xsd_dir_path
      @dir_path = Dir.pwd
    end

    def schema_version(file)
      api_path = "api/schemas/xml/"
      api_path_start = file.index(api_path) + api_path.length
      schema_version = file[api_path_start..].split("/").first
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

      raise Boundary::XsdFilesNotFound, "No xsd files were found in #{@dir_path + xsd_dir_path} directory" if files.nil? || files.empty?

      files
    end

  private

    def sap_defnied_in_rdsap_dir?(file)
      assessment_type == "SAP" && file.end_with?("SAP-Domains.xsd")
    end

    def sap_xsd_files
      Dir.glob("#{@dir_path + xsd_dir_path}*-Domains.xsd")
    end

    def rdsap_xsd_files
      Dir.glob("#{@dir_path + xsd_dir_path}SAP-Domains.xsd")
    end

    def cepc_xsd_files
      Dir.glob("#{@dir_path + xsd_dir_path}Reported-Data.xsd")
    end
  end
end
