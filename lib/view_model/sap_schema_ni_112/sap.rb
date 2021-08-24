module ViewModel
  module SapSchemaNi112
    class Sap < ViewModel::SapSchemaNi112::CommonSchema
      def cylinder_insul_thickness
        xpath(%w[Hot-Water-Store-Insulation-Thickness])
      end

      def cylinder_insulation_type
        xpath(%w[Hot-Water-Store-Insulation-Type])
      end

      def cylinder_size
        xpath(%w[Hot-Water-Store-Size])
      end

      def mechanical_ventilation
        xpath(%w[Mechanical-Ventilation])
      end
    end
  end
end
