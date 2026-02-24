require "date"

module ViewModel
  module Cs63
    class CommonSchema < ViewModel::DomesticEpcViewModel
      THRESHOLD_LOW_ENERGY_LIGHTING_EFFICACY = 65

      def assessment_id
        xpath(%w[Report-Header RRN])
      end

      def epc_assessment_id
        xpath(%w[Report-Header EPC-RRN])
      end

      def sale_lease_date
        xpath(%w[Report-Header Sale-Lease-Date])
      end

      def assessment_date
        xpath(%w[Report-Header Assessment-Date])
      end

      def plan_report_date
        xpath(%w[Report-Header Plan-Report-Date])
      end

      def delegated_protocol_date
        xpath(%w[Delegated-Protocol-Date])
      end

      def report_type
        xpath(%w[Report-Header Report-Type])
      end

      def address_line1
        xpath(%w[Report-Header Property Address Address-Line-1])
      end

      def address_line2
        xpath(%w[Report-Header Property Address Address-Line-2])
      end

      def address_line3
        xpath(%w[Report-Header Property Address Address-Line-3])
      end

      def address_line4
        xpath(%w[Report-Header Property Address Address-Line-4])
      end

      def town
        xpath(%w[Report-Header Property Address Post-Town])
      end

      def postcode
        xpath(%w[Report-Header Property Address Postcode])
      end

      def scheme_assessor_id
        xpath(%w[Energy-Assessor Membership-Number]) or xpath(%w[Energy-Assessor Certificate-Number])
      end

      def assessor_name
        xpath(%w[Energy-Assessor Name])
      end

      # def approved_organisation_name
      #   xpath(%w[Energy-Assessor Approved-Organisation-Name])
      # end
      #
      # def approved_organisation_web_address
      #   xpath(%w[Energy-Assessor Approved-Organisation-Name])
      # end

      def trading_address
        xpath(%w[Energy-Assessor Trading-Address])
      end

      def company_name
        xpath(%w[Energy-Assessor Company-Name])
      end

      def status
        xpath(%w[Energy-Assessor Status])
      end

      def assessor_email
        xpath(%w[Energy-Assessor/E-Mail])
      end

      def assessor_telephone
        xpath(%w[Energy-Assessor/Telephone-Number])
      end

      def address_id
        xpath(%w[UPRN])
      end

      # def type_of_assessment
      #   "CS63"
      # end

      def owner_commission_report
        xpath(%w[Owner-Commission-Report])
      end

      def delegated_person_commission_report
        xpath(%w[Delegated-Person-Commission-Report])
      end

      def property_type_short_description
        xpath(%w[Property-Type Short-Description])
      end

      def property_type_long_description
        xpath(%w[Property-Type Long-Description])
      end

      def building_improvements
        xpath(%w[Improvement-Type Building-Improvements])
      end

      def operational_ratings
        xpath(%w[Improvement-Type Operational-Rating])
      end

      def dec
        xpath(%w[Operational-Rating-System Display-Energy-Certificate])
      end

      def planned_completion_date
        xpath(%w[Improvements-Completion Planned-Completion-Date])
      end

      def actual_completion_date
        xpath(%w[Improvements-Completion Actual-Completion-Date])
      end

      def target_emission_savings
        xpath(%w[Target-Savings Target-Emission-Savings])&.to_f
      end

      def target_energy_savings
        xpath(%w[Target-Savings Target-Energy-Savings])&.to_f
      end

      def accept_prescriptive_improvements
        xpath(%w[Prescriptive-Improvements Accept-Prescriptive-Improvements])
      end

      def prescriptive_improvements
        @xml_doc
          .search("Prescriptive-Improvements Prescriptive-Scenario")
          .map do |node|
          {
            measure_description_short:
              xpath(%w[Measure-Description-Short], node),
            measure_description_long:
              xpath(%w[Measure-Description-Long], node),
            measure_valid: xpath(%w[Measure-Valid], node),
            measure_type: xpath(%w[Measure-Type], node),
          }
        end
      end

      def alternative_improvements
        @xml_doc
          .search("Alternative-Improvements Alternative-Scenario")
          .map do |node|
          {
            measure_description_short:
              xpath(%w[Measure-Description-Short], node),
            measure_description_long:
              xpath(%w[Measure-Description-Long], node),
            measure_valid: xpath(%w[Measure-Valid], node),
            measure_type: xpath(%w[Measure-Type], node),
          }
        end
      end

      def date_of_registration
        xpath(%w[Report-Header Plan-Report-Date])
      end

      def date_of_expiry
        Date.parse(date_of_registration).next_month(42).to_s
      end

      def date_of_assessment
        xpath(%w[Report-Header Assessment-Date])
      end

      def related_rrn
        nil
      end
    end
  end
end
