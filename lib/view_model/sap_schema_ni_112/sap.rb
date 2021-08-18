module ViewModel
  module SapSchemaNi112
    class Sap < ViewModel::SapSchemaNi112::CommonSchema

      def cylinder_insul_thickness
        xpath(%w[Hot-Water-Store-Insulation-Thickness])
      end

    end
  end
end
