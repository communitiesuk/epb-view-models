module ViewModelGateway
  class XsdFilesGateway
    attr_reader :simple_type, :assessment_type, :xsd_dir_path, :glob_path

    API_PATH = "api/schemas/xml/".freeze
    XSD_DEFAULT_PATH = "/api/schemas/xml/**/".freeze

    def initialize(domain_arguments)
      @simple_type = domain_arguments.simple_type
      @assessment_type = domain_arguments.assessment_type
      @xsd_dir_path = domain_arguments.xsd_dir_path
      @dir_path = Dir.pwd if domain_arguments.gem_path.nil? || domain_arguments.gem_path.empty?
    end

    def schema_version(file)
      api_path_start = file.index(API_PATH) + API_PATH.length
      schema_version = file[api_path_start..].split("/").first
      sap_defined_in_rdsap_dir?(file) ? "#{schema_version}/SAP" : schema_version
    end

    def xsd_files
      files = if @xsd_dir_path.nil? || @xsd_dir_path.empty?
                case @assessment_type.downcase
                when "sap"
                  sap_xsd_files
                when "rdsap"
                  rdsap_xsd_files
                when "cepc"
                  cepc_xsd_files
                end
              else
                @glob_path = "#{@dir_path}#{@xsd_dir_path}"
                Dir.glob(@glob_path)
              end

      raise ViewModelBoundary::XsdFilesNotFound, "No xsd files were found in #{@glob_path} directory" if files.nil? || files.empty?

      files
    end

  private

    def sap_defined_in_rdsap_dir?(file)
      assessment_type == "SAP" && file.end_with?("SAP-Domains.xsd")
    end

    def sap_xsd_files
      @glob_path = "#{@dir_path + XSD_DEFAULT_PATH}*-Domains.xsd"
      Dir.glob(@glob_path)
    end

    def rdsap_xsd_files
      @glob_path = "#{@dir_path + XSD_DEFAULT_PATH}*-Domains.xsd"
      Dir.glob(@glob_path)
    end

    def cepc_xsd_files
      @glob_path = "#{@dir_path + XSD_DEFAULT_PATH}Reported-Data.xsd"
      Dir.glob(@glob_path)
    end
  end
end
