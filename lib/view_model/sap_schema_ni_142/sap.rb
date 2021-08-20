module ViewModel
  module SapSchemaNi142
    class Sap < ViewModel::SapSchemaNi142::CommonSchema
      def property_age_band
        construction_year
      end

      def construction_year
        xpath(%w[Construction-Year])
      end

      def cylinder_insul_thickness
        xpath(%w[Hot-Water-Store-Insulation-Thickness])
      end
    end
  end
end
