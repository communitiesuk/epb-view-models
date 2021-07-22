module ViewModel
  class AcCertWrapper
    attr_reader :view_model

    def initialize(xml_doc, schema_type)
      @view_model = build_view_model(xml_doc, schema_type)
      @summary = Presenter::AcCert::Summary.new(@view_model)
    end

    def type
      :AC_CERT
    end

    def to_hash
      @summary.to_hash
    end

  private

    def build_view_model(xml_doc, schema_type)
      case schema_type
      when :"CEPC-8.0.0"
        ViewModel::Cepc800::AcCert.new xml_doc
      when :"CEPC-NI-8.0.0"
        ViewModel::CepcNi800::AcCert.new xml_doc
      when :"CEPC-7.1"
        ViewModel::Cepc71::AcCert.new xml_doc
      when :"CEPC-7.0"
        ViewModel::Cepc70::AcCert.new xml_doc
      else
        raise ArgumentError, "Unsupported schema type"
      end
    end
  end
end
