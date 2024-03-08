require_relative "../xml_view_test_helper"

RSpec.describe ViewModel::RdSapWrapper do
  it "returns the expect view_model_boundary without a valid schema type" do
    expect { described_class.new("", "invalid", {}) }.to raise_error(
      ArgumentError,
    ).with_message "Unsupported schema type"
  end

  context "when general schemas are parsed" do
    describe ".to_hash" do
      let(:schemas) do
        [
          { schema: "RdSAP-Schema-21.0.0",
            different_fields: {
              property_age_band: "M",
              transaction_type: "16",
              gas_smart_meter_present: false,
              country_code: "ENG",
              electricity_smart_meter_present: true,
            } },
          { schema: "RdSAP-Schema-20.0.0" },
          {
            schema: "RdSAP-Schema-19.0",
            different_buried_fields: {
              address: {
                address_id: "LPRN-0000000000",
              },
            },
            different_fields: {
              addendum: {
                addendum_number: [1],
              },
              lzc_energy_sources: [11],
            },
          },
          {
            schema: "RdSAP-Schema-18.0",
            different_buried_fields: {
              address: {
                address_id: "LPRN-0000000000",
              },
            },
            different_fields: {
              addendum: {
                stone_walls: true,
                system_build: true,
              },
              lzc_energy_sources: [11, 12],
            },
          },
          {
            schema: "RdSAP-Schema-17.1",
            different_buried_fields: {
              address: {
                address_id: "LPRN-0000000000",
              },
            },
            different_fields: {
              addendum: nil,
            },
          },
          {
            schema: "RdSAP-Schema-17.0",
            different_buried_fields: {
              address: {
                address_id: "LPRN-0000000000",
              },
            },
            different_fields: {
              addendum: nil,
            },
          },
        ]
      end

      let(:assertion) do
        {
          type_of_assessment: "RdSAP",
          assessment_id: "0000-0000-0000-0000-0000",
          date_of_expiry: "2030-05-03",
          date_of_assessment: "2020-05-04",
          date_of_registration: "2020-05-04",
          date_registered: "2020-05-04",
          address_line1: "1 Some Street",
          address_line2: "",
          address_line3: "",
          address_line4: "",
          town: "Whitbury",
          postcode: "A0 0AA",
          address: {
            address_id: "UPRN-000000000000",
            address_line1: "1 Some Street",
            address_line2: "",
            address_line3: "",
            address_line4: "",
            town: "Whitbury",
            postcode: "A0 0AA",
          },
          assessor: {
            scheme_assessor_id: "SPEC000000",
            name: "Testa Sessor",
            contact_details: {
              email: "a@b.c",
              telephone: "0555 497 2848",
            },
          },
          current_carbon_emission: 2.4,
          current_energy_efficiency_band: "e",
          current_energy_efficiency_rating: 50,
          dwelling_type: "Mid-terrace house",
          estimated_energy_cost: "689.83",
          main_fuel_type: "26",
          heat_demand: {
            current_space_heating_demand: 13_120,
            current_water_heating_demand: 2285,
            impact_of_cavity_insulation: -122,
            impact_of_loft_insulation: -2114,
            impact_of_solid_wall_insulation: -3560,
          },
          heating_cost_current: "365.98",
          heating_cost_potential: "250.34",
          hot_water_cost_current: "200.40",
          hot_water_cost_potential: "180.43",
          lighting_cost_current: "123.45",
          lighting_cost_potential: "84.23",
          potential_carbon_emission: 1.4,
          potential_energy_efficiency_band: "c",
          potential_energy_efficiency_rating: 72,
          potential_energy_saving: "174.83",
          primary_energy_use: "230",
          energy_consumption_potential: "88",
          property_age_band: "K",
          property_summary: [
            {
              description: "Solid brick, as built, no insulation (assumed)",
              energy_efficiency_rating: 1,
              environmental_efficiency_rating: 1,
              name: "wall",
            },
            {
              description: "Cavity wall, as built, insulated (assumed)",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "wall",
            },
            {
              description: "Pitched, 25 mm loft insulation",
              energy_efficiency_rating: 2,
              environmental_efficiency_rating: 2,
              name: "roof",
            },
            {
              description: "Pitched, 250 mm loft insulation",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "roof",
            },
            {
              description: "Suspended, no insulation (assumed)",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "floor",
            },
            {
              description: "Solid, insulated (assumed)",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "floor",
            },
            {
              description: "Fully double glazed",
              energy_efficiency_rating: 3,
              environmental_efficiency_rating: 3,
              name: "window",
            },
            {
              description: "Boiler and radiators, anthracite",
              energy_efficiency_rating: 3,
              environmental_efficiency_rating: 1,
              name: "main_heating",
            },
            {
              description: "Boiler and radiators, mains gas",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "main_heating",
            },
            {
              description: "Programmer, room thermostat and TRVs",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "main_heating_controls",
            },
            {
              description: "Time and temperature zone control",
              energy_efficiency_rating: 5,
              environmental_efficiency_rating: 5,
              name: "main_heating_controls",
            },
            {
              description: "From main system",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "hot_water",
            },
            {
              description: "Low energy lighting in 50% of fixed outlets",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "lighting",
            },
            {
              description: "Room heaters, electric",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "secondary_heating",
            },
          ],
          recommended_improvements: [
            {
              energy_performance_rating_improvement: 50,
              energy_performance_band_improvement: "e",
              environmental_impact_rating_improvement: 50,
              green_deal_category_code: "1",
              improvement_category: "6",
              improvement_code: "5",
              improvement_description: nil,
              improvement_title: "",
              improvement_type: "Z3",
              indicative_cost: "£100 - £350",
              sequence: 1,
              typical_saving: "360",
            },
            {
              energy_performance_rating_improvement: 60,
              energy_performance_band_improvement: "d",
              environmental_impact_rating_improvement: 64,
              green_deal_category_code: "3",
              improvement_category: "2",
              improvement_code: "1",
              improvement_description: nil,
              improvement_title: "",
              improvement_type: "Z2",
              indicative_cost: "2000",
              sequence: 2,
              typical_saving: "99",
            },
            {
              energy_performance_rating_improvement: 60,
              energy_performance_band_improvement: "d",
              environmental_impact_rating_improvement: 64,
              green_deal_category_code: "3",
              improvement_category: "2",
              improvement_code: nil,
              improvement_description: "Improvement desc",
              improvement_title: "",
              improvement_type: "Z2",
              indicative_cost: "1000",
              sequence: 3,
              typical_saving: "99",
            },
          ],
          lzc_energy_sources: nil,
          related_party_disclosure_number: nil,
          related_party_disclosure_text: "No related party",
          tenure: "1",
          transaction_type: "1",
          total_floor_area: 55.0,
          status: "ENTERED",
          country_code: "EAW",
          environmental_impact_current: 52,
          addendum: {
            addendum_number: [1, 8],
            stone_walls: true,
            system_build: true,
          },
          gas_smart_meter_present: nil,
          electricity_smart_meter_present: nil,
        }
      end

      it "read the appropriate values" do
        test_xml_doc(schemas, assertion)
      end
    end

    describe ".to_hash_ni" do
      let(:schemas) do
        [
          { schema: "RdSAP-Schema-20.0.0" },
          { schema: "RdSAP-Schema-19.0" },
          { schema: "RdSAP-Schema-18.0" },
          { schema: "RdSAP-Schema-17.1" },
          { schema: "RdSAP-Schema-17.0" },
        ]
      end

      let(:assertion) do
        {
          address1: "1 Some Street",
          address2: "",
          address3: "",
          built_form: "Semi-Detached",
          co2_emiss_curr_per_floor_area: "20",
          co2_emissions_current: "2.4",
          co2_emissions_potential: "1.4",
          construction_age_band: "England and Wales: 2007-2011",
          current_energy_efficiency: "50",
          current_energy_rating: "e",
          cylinder_insul_thickness: "12",
          cylinder_insulation_type: "1",
          has_cylinder_thermostat: "true",
          cylinder_size: "1",
          energy_consumption_current: "230",
          energy_consumption_potential: "88",
          energy_tariff: "Single",
          environment_impact_current: 52,
          environment_impact_potential: 74,
          extension_count: 0,
          fixed_lighting_outlets_count: 16,
          flat_top_storey: "N",
          flat_storey_count: 3,
          floor_description: "Suspended, no insulation (assumed)",
          floor_energy_eff: "N/A",
          floor_env_eff: "N/A",
          floor_height: "2.45",
          floor_level: "01",
          glazed_area: "Normal",
          glazed_type: "double glazing installed during or after 2002",
          heat_loss_corridor: "unheated corridor",
          heating_cost_current: "365.98",
          heating_cost_potential: "250.34",
          hot_water_cost_current: "200.40",
          hot_water_cost_potential: "180.43",
          hot_water_energy_eff: "Good",
          hot_water_env_eff: "Good",
          hotwater_description: "From main system",
          inspection_date: "2020-05-04",
          lighting_cost_current: "123.45",
          lighting_cost_potential: "84.23",
          lighting_description: "Low energy lighting in 50% of fixed outlets",
          lighting_energy_eff: "Good",
          lighting_env_eff: "Good",
          low_energy_lighting: "100",
          low_energy_fixed_lighting_count: 16,
          main_fuel: "mains gas (not community)",
          mainheat_description: "Boiler and radiators, anthracite, Boiler and radiators, mains gas",
          mainheat_energy_eff: "Average",
          mainheat_env_eff: "Very Poor",
          mainheatc_energy_eff: "Good",
          mainheatc_env_eff: "Good",
          mainheatcont_description: "Programmer, room thermostat and TRVs",
          mains_gas_flag: "Y",
          mechanical_ventilation: "natural",
          mech_vent_sys_index_number: nil,
          mechanical_vent_data_source: nil,
          multi_glaze_proportion: "100",
          number_habitable_rooms: 5,
          number_heated_rooms: 5,
          number_open_fireplaces: 0,
          photo_supply: "0",
          posttown: "Whitbury",
          postcode: "A0 0AA",
          potential_energy_efficiency: "72",
          potential_energy_rating: "c",
          property_type: "House",
          report_type: "2",
          roof_description: "Pitched, 25 mm loft insulation",
          roof_energy_eff: "Poor",
          roof_env_eff: "Poor",
          secondheat_description: "Room heaters, electric",
          sheating_energy_eff: "N/A",
          sheating_env_eff: "N/A",
          solar_water_heating_flag: "N",
          tenure: "Owner-occupied",
          thermal_store: nil,
          total_floor_area: "55",
          transaction_type: "marketed sale",
          unheated_corridor_length: "10",
          ventilation_type: nil,
          walls_description: "Solid brick, as built, no insulation (assumed)",
          walls_energy_eff: "Very Poor",
          walls_env_eff: "Very Poor",
          water_heating_fuel: "mains gas (not community)",
          water_heating_code: "901",
          wind_turbine_count: 0,
          windows_description: "Fully double glazed",
          windows_energy_eff: "Average",
          windows_env_eff: "Average",
        }
      end

      it "reads the appropriate values" do
        test_xml_doc(schemas, assertion, :to_hash_ni)
      end
    end

    describe ".to_recommendation_report" do
      let(:schemas) do
        rdsap_20_with_description_and_summary = {
          different_fields: {
            recommendations: [
              {
                assessment_id: "0000-0000-0000-0000-0000",
                improvement_code: "5",
                improvement_description: "Increase loft insulation to 270 mm",
                improvement_summary: "Increase loft insulation to 270 mm",
                indicative_cost: "£100 - £350",
                sequence: 1,
              },
              {
                assessment_id: "0000-0000-0000-0000-0000",
                improvement_code: "1",
                improvement_description: "Insulate hot water cylinder with 80 mm jacket",
                improvement_summary: "Insulate hot water cylinder with 80 mm jacket",
                indicative_cost: "2000",
                sequence: 2,
              },
              {
                assessment_id: "0000-0000-0000-0000-0000",
                improvement_code: nil,
                improvement_description: "Improvement desc",
                improvement_summary: nil,
                indicative_cost: "1000",
                sequence: 3,
              },
            ],
          },
        }
        [
          { schema: "RdSAP-Schema-20.0.0" }.deep_merge(rdsap_20_with_description_and_summary),
          { schema: "RdSAP-Schema-19.0" },
          { schema: "RdSAP-Schema-18.0" },
          { schema: "RdSAP-Schema-17.1" },
          { schema: "RdSAP-Schema-17.0" },
        ]
      end

      let(:recommendation_assertion) do
        {
          recommendations: [
            {
              assessment_id: "0000-0000-0000-0000-0000",
              improvement_code: "5",
              improvement_description: nil,
              improvement_summary: nil,
              indicative_cost: "£100 - £350",
              sequence: 1,
            },
            {
              assessment_id: "0000-0000-0000-0000-0000",
              improvement_code: "1",
              improvement_description: nil,
              improvement_summary: nil,
              indicative_cost: "2000",
              sequence: 2,
            },
            {
              assessment_id: "0000-0000-0000-0000-0000",
              improvement_code: nil,
              improvement_description: "Improvement desc",
              improvement_summary: nil,
              indicative_cost: "1000",
              sequence: 3,
            },
          ],
        }
      end

      it "reads the appropriate values" do
        test_xml_doc(schemas, recommendation_assertion, :to_recommendation_report)
      end
    end

    describe ".to_report" do
      let(:schemas) do
        [
          {
            schema: "RdSAP-Schema-21.0.0",
            different_fields: {
              assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
              construction_age_band: "England and Wales: 2022 onwards",
              transaction_type: "Non-grant scheme (e.g. MEES)",
              mechanical_ventilation: "positive input from outside",
              glazed_area: nil,
              low_energy_lighting: nil,
              fixed_lighting_outlets_count: nil,
              low_energy_fixed_lighting_outlets_count: nil,
              number_open_fireplaces: nil,
              glazed_type: nil,

            },
          },
          {
            schema: "RdSAP-Schema-20.0.0",
            different_fields: {
              assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
            },
          },
          {
            schema: "RdSAP-Schema-19.0",
            different_fields: {
              assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
            },
          },
          {
            schema: "RdSAP-Schema-18.0",
            different_fields: {
              assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
            },
          },
          {
            schema: "RdSAP-Schema-17.1",
            different_fields: {
              assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
            },
          },
          {
            schema: "RdSAP-Schema-17.0",
            different_fields: {
              assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
            },
          },
        ]
      end

      let(:assertion) do
        {
          assessment_id: "0000-0000-0000-0000-0000",
          inspection_date: "2020-05-04",
          lodgement_date: "2020-05-04",
          building_reference_number: "UPRN-000000000123",
          address1: "1 Some Street",
          address2: "",
          address3: "",
          posttown: "Whitbury",
          postcode: "A0 0AA",
          construction_age_band: "England and Wales: 2007-2011",
          current_energy_rating: "e",
          potential_energy_rating: "c",
          current_energy_efficiency: "50",
          potential_energy_efficiency: "72",
          property_type: "House",
          tenure: "Owner-occupied",
          transaction_type: "marketed sale",
          environment_impact_current: 52,
          environment_impact_potential: 74,
          energy_consumption_current: "230",
          energy_consumption_potential: "88",
          co2_emissions_current: "2.4",
          co2_emiss_curr_per_floor_area: "20",
          co2_emissions_potential: "1.4",
          heating_cost_current: "365.98",
          heating_cost_potential: "250.34",
          hot_water_cost_current: "200.40",
          hot_water_cost_potential: "180.43",
          lighting_cost_current: "123.45",
          lighting_cost_potential: "84.23",
          total_floor_area: "55",
          mains_gas_flag: "Y",
          flat_top_storey: "N",
          flat_storey_count: 3,
          multi_glaze_proportion: "100",
          glazed_area: "Normal",
          number_habitable_rooms: 5,
          number_heated_rooms: 5,
          low_energy_lighting: "100",
          fixed_lighting_outlets_count: 16,
          low_energy_fixed_lighting_outlets_count: 16,
          number_open_fireplaces: 0,
          hotwater_description: "From main system",
          hot_water_energy_eff: "Good",
          hot_water_env_eff: "Good",
          wind_turbine_count: 0,
          heat_loss_corridor: "unheated corridor",
          unheated_corridor_length: "10",
          windows_description: "Fully double glazed",
          windows_energy_eff: "Average",
          windows_env_eff: "Average",
          secondheat_description: "Room heaters, electric",
          sheating_energy_eff: "N/A",
          sheating_env_eff: "N/A",
          lighting_description: "Low energy lighting in 50% of fixed outlets",
          lighting_energy_eff: "Good",
          lighting_env_eff: "Good",
          photo_supply: "0",
          built_form: "Semi-Detached",
          mainheat_description:
            "Boiler and radiators, anthracite, Boiler and radiators, mains gas",
          mainheat_energy_eff: "Average",
          mainheat_env_eff: "Very Poor",
          extension_count: 0,
          report_type: "2",
          mainheatcont_description: "Programmer, room thermostat and TRVs",
          roof_description: "Pitched, 25 mm loft insulation",
          roof_energy_eff: "Poor",
          roof_env_eff: "Poor",
          walls_description: "Solid brick, as built, no insulation (assumed)",
          walls_energy_eff: "Very Poor",
          walls_env_eff: "Very Poor",
          energy_tariff: "Single",
          floor_level: "01",
          solar_water_heating_flag: "N",
          mechanical_ventilation: "natural",
          floor_height: "2.45",
          main_fuel: "mains gas (not community)",
          floor_description: "Suspended, no insulation (assumed)",
          floor_energy_eff: "N/A",
          floor_env_eff: "N/A",
          mainheatc_energy_eff: "Good",
          mainheatc_env_eff: "Good",
          glazed_type: "double glazing installed during or after 2002",
        }
      end

      let(:additional_data) do
        {
          "address_id": "UPRN-000000000123",
        }
      end

      it "reads the appropriate values" do
        test_xml_doc(schemas, assertion, :to_report, additional_data)
      end
    end

    describe ".to_domestic_digest" do
      let(:schemas) do
        [
          { schema: "RdSAP-Schema-21.0.0",
            different_fields: { main_dwelling_construction_age_band_or_year: "England and Wales: 2022 onwards" } },
          { schema: "RdSAP-Schema-20.0.0" },
          { schema: "RdSAP-Schema-19.0" },
          { schema: "RdSAP-Schema-18.0" },
          { schema: "RdSAP-Schema-17.1" },
          { schema: "RdSAP-Schema-17.0" },
        ]
      end

      let(:assertion) do
        {
          type_of_assessment: "RdSAP",
          assessment_id: "0000-0000-0000-0000-0000",
          date_of_registration: "2020-05-04",
          address: {
            address_line1: "1 Some Street",
            address_line2: "",
            address_line3: "",
            address_line4: "",
            town: "Whitbury",
            postcode: "A0 0AA",
          },
          dwelling_type: "Mid-terrace house",
          built_form: "Semi-Detached",
          main_dwelling_construction_age_band_or_year: "England and Wales: 2007-2011",
          property_summary: [
            {
              description: "Solid brick, as built, no insulation (assumed)",
              energy_efficiency_rating: 1,
              environmental_efficiency_rating: 1,
              name: "wall",
            },
            {
              description: "Cavity wall, as built, insulated (assumed)",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "wall",
            },
            {
              description: "Pitched, 25 mm loft insulation",
              energy_efficiency_rating: 2,
              environmental_efficiency_rating: 2,
              name: "roof",
            },
            {
              description: "Pitched, 250 mm loft insulation",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "roof",
            },
            {
              description: "Suspended, no insulation (assumed)",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "floor",
            },
            {
              description: "Solid, insulated (assumed)",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "floor",
            },
            {
              description: "Fully double glazed",
              energy_efficiency_rating: 3,
              environmental_efficiency_rating: 3,
              name: "window",
            },
            {
              description: "Boiler and radiators, anthracite",
              energy_efficiency_rating: 3,
              environmental_efficiency_rating: 1,
              name: "main_heating",
            },
            {
              description: "Boiler and radiators, mains gas",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "main_heating",
            },
            {
              description: "Programmer, room thermostat and TRVs",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "main_heating_controls",
            },
            {
              description: "Time and temperature zone control",
              energy_efficiency_rating: 5,
              environmental_efficiency_rating: 5,
              name: "main_heating_controls",
            },
            {
              description: "From main system",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "hot_water",
            },
            {
              description: "Low energy lighting in 50% of fixed outlets",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "lighting",
            },
            {
              description: "Room heaters, electric",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "secondary_heating",
            },
          ],
          main_heating_category: "boiler with radiators or underfloor heating",
          main_fuel_type: "mains gas (not community)",
          has_hot_water_cylinder: "true",
          total_floor_area: "55",
          has_mains_gas: "Y",
          current_energy_efficiency_rating: 50,
          potential_energy_efficiency_rating: 72,
          type_of_property: "House",
          recommended_improvements: [{ energy_performance_rating_improvement: 50,
                                       energy_performance_band_improvement: "e",
                                       environmental_impact_rating_improvement: 50,
                                       green_deal_category_code: "1",
                                       improvement_category: "6",
                                       improvement_code: "5",
                                       improvement_description: nil,
                                       improvement_title: "",
                                       improvement_type: "Z3",
                                       indicative_cost: "£100 - £350",
                                       sequence: 1,
                                       typical_saving: "360" },
                                     { energy_performance_rating_improvement: 60,
                                       energy_performance_band_improvement: "d",
                                       environmental_impact_rating_improvement: 64,
                                       green_deal_category_code: "3",
                                       improvement_category: "2",
                                       improvement_code: "1",
                                       improvement_description: nil,
                                       improvement_title: "",
                                       improvement_type: "Z2",
                                       indicative_cost: "2000",
                                       sequence: 2,
                                       typical_saving: "99" },
                                     { energy_performance_rating_improvement: 60,
                                       energy_performance_band_improvement: "d",
                                       environmental_impact_rating_improvement: 64,
                                       green_deal_category_code: "3",
                                       improvement_category: "2",
                                       improvement_code: nil,
                                       improvement_description: "Improvement desc",
                                       improvement_title: "",
                                       improvement_type: "Z2",
                                       indicative_cost: "1000",
                                       sequence: 3,
                                       typical_saving: "99" }],
        }
      end

      context "when using the deprecated to_hera_hash method" do
        it "reads the appropriate values, testing that a deprecation warning is given" do
          expect { test_xml_doc(schemas, assertion, :to_hera_hash) }.to output(/deprecated/).to_stderr
        end
      end

      it "reads the appropriate values" do
        test_xml_doc(schemas, assertion, :to_domestic_digest)
      end
    end
  end

  context "when Northern Ireland schemas are parsed" do
    describe ".to_hash" do
      let(:schemas) do
        [
          {
            schema: "RdSAP-Schema-NI-20.0.0",
            unsupported_fields: %i[improvement_summary],
            different_buried_fields: {
              address: {
                address_id: "UPRN-000000000000",
              },
            },
          },
          {
            schema: "RdSAP-Schema-NI-19.0",
            different_fields: {
              addendum: {
                stone_walls: true,
                system_build: true,
              },
              lzc_energy_sources: [11],
            },
          },
          {
            schema: "RdSAP-Schema-NI-18.0",
            different_fields: {
              addendum: {
                addendum_number: [1],
              },
              lzc_energy_sources: [11, 12],
            },
          },
          {
            schema: "RdSAP-Schema-NI-17.4",
            different_fields: {
              addendum: {
                addendum_number: [1, 8],
                stone_walls: true,
                system_build: true,
              },
            },
          },
          { schema: "RdSAP-Schema-NI-17.3" },
        ]
      end

      let(:assertion) do
        {
          type_of_assessment: "RdSAP",
          assessment_id: "0000-0000-0000-0000-0000",
          date_of_expiry: "2030-05-03",
          date_of_assessment: "2020-05-04",
          date_of_registration: "2020-05-04",
          date_registered: "2020-05-04",
          address_line1: "1 Some Street",
          address_line2: "",
          address_line3: "",
          address_line4: "",
          town: "Whitbury",
          postcode: "A0 0AA",
          address: {
            address_id: "LPRN-0000000000",
            address_line1: "1 Some Street",
            address_line2: "",
            address_line3: "",
            address_line4: "",
            town: "Whitbury",
            postcode: "A0 0AA",
          },
          assessor: {
            scheme_assessor_id: "SPEC000000",
            name: "Testa Sessor",
            contact_details: {
              email: "a@b.c",
              telephone: "0555 497 2848",
            },
          },
          current_carbon_emission: 2.4,
          current_energy_efficiency_band: "e",
          current_energy_efficiency_rating: 50,
          dwelling_type: "Mid-terrace house",
          estimated_energy_cost: "689.83",
          main_fuel_type: "26",
          heat_demand: {
            current_space_heating_demand: 13_120,
            current_water_heating_demand: 2285,
            impact_of_cavity_insulation: -122,
            impact_of_loft_insulation: -2114,
            impact_of_solid_wall_insulation: -3560,
          },
          heating_cost_current: "365.98",
          heating_cost_potential: "250.34",
          hot_water_cost_current: "200.40",
          hot_water_cost_potential: "180.43",
          lighting_cost_current: "123.45",
          lighting_cost_potential: "84.23",
          potential_carbon_emission: 1.4,
          potential_energy_efficiency_band: "c",
          potential_energy_efficiency_rating: 72,
          potential_energy_saving: "174.83",
          primary_energy_use: "230",
          energy_consumption_potential: "88",
          property_age_band: "K",
          property_summary: [
            {
              description: "Solid brick, as built, no insulation (assumed)",
              energy_efficiency_rating: 1,
              environmental_efficiency_rating: 1,
              name: "wall",
            },
            {
              description: "Cavity wall, as built, insulated (assumed)",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "wall",
            },
            {
              description: "Pitched, 25 mm loft insulation",
              energy_efficiency_rating: 2,
              environmental_efficiency_rating: 2,
              name: "roof",
            },
            {
              description: "Pitched, 250 mm loft insulation",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "roof",
            },
            {
              description: "Suspended, no insulation (assumed)",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "floor",
            },
            {
              description: "Solid, insulated (assumed)",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "floor",
            },
            {
              description: "Fully double glazed",
              energy_efficiency_rating: 3,
              environmental_efficiency_rating: 3,
              name: "window",
            },
            {
              description: "Boiler and radiators, anthracite",
              energy_efficiency_rating: 3,
              environmental_efficiency_rating: 1,
              name: "main_heating",
            },
            {
              description: "Boiler and radiators, mains gas",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "main_heating",
            },
            {
              description: "Programmer, room thermostat and TRVs",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "main_heating_controls",
            },
            {
              description: "Time and temperature zone control",
              energy_efficiency_rating: 5,
              environmental_efficiency_rating: 5,
              name: "main_heating_controls",
            },
            {
              description: "From main system",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "hot_water",
            },
            {
              description: "Low energy lighting in 50% of fixed outlets",
              energy_efficiency_rating: 4,
              environmental_efficiency_rating: 4,
              name: "lighting",
            },
            {
              description: "Room heaters, electric",
              energy_efficiency_rating: 0,
              environmental_efficiency_rating: 0,
              name: "secondary_heating",
            },
          ],
          recommended_improvements: [
            {
              energy_performance_rating_improvement: 50,
              energy_performance_band_improvement: "e",
              environmental_impact_rating_improvement: 50,
              green_deal_category_code: "1",
              improvement_category: "6",
              improvement_code: "5",
              improvement_description: nil,
              improvement_title: "",
              improvement_type: "Z3",
              indicative_cost: "£100 - £350",
              sequence: 1,
              typical_saving: "360",
            },
            {
              energy_performance_rating_improvement: 60,
              energy_performance_band_improvement: "d",
              environmental_impact_rating_improvement: 64,
              green_deal_category_code: "3",
              improvement_category: "2",
              improvement_code: "1",
              improvement_description: nil,
              improvement_title: "",
              improvement_type: "Z2",
              indicative_cost: "2000",
              sequence: 2,
              typical_saving: "99",
            },
            {
              energy_performance_rating_improvement: 60,
              energy_performance_band_improvement: "d",
              environmental_impact_rating_improvement: 64,
              green_deal_category_code: "3",
              improvement_category: "2",
              improvement_code: nil,
              improvement_description: "Improvement desc",
              improvement_title: "",
              improvement_type: "Z2",
              indicative_cost: "1000",
              sequence: 3,
              typical_saving: "99",
            },
          ],
          lzc_energy_sources: nil,
          related_party_disclosure_number: nil,
          related_party_disclosure_text: "No related party",
          tenure: "1",
          transaction_type: "1",
          total_floor_area: 55.0,
          status: "ENTERED",
          environmental_impact_current: 52,
          addendum: nil,
          gas_smart_meter_present: nil,
          electricity_smart_meter_present: nil,
        }
      end

      it "read the appropriate values" do
        test_xml_doc(schemas, assertion)
      end
    end

    describe ".to_hash_ni" do
      let(:schemas) do
        [
          { schema: "RdSAP-Schema-NI-20.0.0" },
          { schema: "RdSAP-Schema-NI-19.0" },
          { schema: "RdSAP-Schema-NI-18.0" },
          { schema: "RdSAP-Schema-NI-17.4" },
          { schema: "RdSAP-Schema-NI-17.3" },
        ]
      end

      let(:assertion) do
        {
          address1: "1 Some Street",
          address2: "",
          address3: "",
          built_form: "Semi-Detached",
          co2_emiss_curr_per_floor_area: "20",
          co2_emissions_current: "2.4",
          co2_emissions_potential: "1.4",
          construction_age_band: "Northern Ireland: 2007-2013",
          current_energy_efficiency: "50",
          current_energy_rating: "e",
          cylinder_insul_thickness: "12",
          cylinder_insulation_type: "1",
          cylinder_size: "1",
          has_cylinder_thermostat: "true",
          energy_consumption_current: "230",
          energy_consumption_potential: "88",
          energy_tariff: "Single",
          environment_impact_current: 52,
          environment_impact_potential: 74,
          extension_count: 0,
          fixed_lighting_outlets_count: 16,
          flat_top_storey: "N",
          flat_storey_count: 3,
          floor_description: "Suspended, no insulation (assumed)",
          floor_energy_eff: "N/A",
          floor_env_eff: "N/A",
          floor_height: "2.45",
          floor_level: "01",
          glazed_area: "Normal",
          glazed_type: "double glazing installed during or after 2002",
          heat_loss_corridor: "unheated corridor",
          heating_cost_current: "365.98",
          heating_cost_potential: "250.34",
          hot_water_cost_current: "200.40",
          hot_water_cost_potential: "180.43",
          hot_water_energy_eff: "Good",
          hot_water_env_eff: "Good",
          hotwater_description: "From main system",
          inspection_date: "2020-05-04",
          lighting_cost_current: "123.45",
          lighting_cost_potential: "84.23",
          lighting_description: "Low energy lighting in 50% of fixed outlets",
          lighting_energy_eff: "Good",
          lighting_env_eff: "Good",
          low_energy_lighting: "100",
          low_energy_fixed_lighting_count: 16,
          main_fuel: "mains gas (not community)",
          mainheat_description: "Boiler and radiators, anthracite, Boiler and radiators, mains gas",
          mainheat_energy_eff: "Average",
          mainheat_env_eff: "Very Poor",
          mainheatc_energy_eff: "Good",
          mainheatc_env_eff: "Good",
          mainheatcont_description: "Programmer, room thermostat and TRVs",
          mains_gas_flag: "Y",
          mech_vent_sys_index_number: nil,
          mechanical_vent_data_source: nil,
          mechanical_ventilation: "natural",
          multi_glaze_proportion: "100",
          number_habitable_rooms: 5,
          number_heated_rooms: 5,
          number_open_fireplaces: 0,
          photo_supply: "0",
          posttown: "Whitbury",
          postcode: "A0 0AA",
          potential_energy_efficiency: "72",
          potential_energy_rating: "c",
          property_type: "House",
          report_type: "2",
          roof_description: "Pitched, 25 mm loft insulation",
          roof_energy_eff: "Poor",
          roof_env_eff: "Poor",
          secondheat_description: "Room heaters, electric",
          sheating_energy_eff: "N/A",
          sheating_env_eff: "N/A",
          solar_water_heating_flag: "N",
          tenure: "Owner-occupied",
          thermal_store: nil,
          total_floor_area: "55",
          transaction_type: "marketed sale",
          unheated_corridor_length: "10",
          ventilation_type: nil,
          walls_description: "Solid brick, as built, no insulation (assumed)",
          walls_energy_eff: "Very Poor",
          walls_env_eff: "Very Poor",
          water_heating_fuel: "mains gas (not community)",
          water_heating_code: "901",
          wind_turbine_count: 0,
          windows_description: "Fully double glazed",
          windows_energy_eff: "Average",
          windows_env_eff: "Average",
        }
      end

      it "reads the appropriate values" do
        test_xml_doc(schemas, assertion, :to_hash_ni)
      end
    end

    describe ".to_report" do
      let(:schemas) do
        [{
          schema: "RdSAP-Schema-NI-20.0.0",
          different_fields: {
            assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
          },
        },
         {
           schema: "RdSAP-Schema-NI-19.0",
           different_fields: {
             assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
           },
         },
         {
           schema: "RdSAP-Schema-NI-18.0",
           different_fields: {
             assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
           },
         },
         {
           schema: "RdSAP-Schema-NI-17.4",
           different_fields: {
             assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
           },
         },
         {
           schema: "RdSAP-Schema-NI-17.3",
           different_fields: {
             assessment_id: "4af9d2c31cf53e72ef6f59d3f59a1bfc500ebc2b1027bc5ca47361435d988e1a",
           },
         }]
      end

      let(:assertion) do
        {
          assessment_id: "0000-0000-0000-0000-0000",
          inspection_date: "2020-05-04",
          lodgement_date: "2020-05-04",
          building_reference_number: "UPRN-0000000123",
          address1: "1 Some Street",
          address2: "",
          address3: "",
          posttown: "Whitbury",
          postcode: "A0 0AA",
          construction_age_band: "Northern Ireland: 2007-2013",
          current_energy_rating: "e",
          potential_energy_rating: "c",
          current_energy_efficiency: "50",
          potential_energy_efficiency: "72",
          property_type: "House",
          tenure: "Owner-occupied",
          transaction_type: "marketed sale",
          environment_impact_current: 52,
          environment_impact_potential: 74,
          energy_consumption_current: "230",
          energy_consumption_potential: "88",
          co2_emissions_current: "2.4",
          co2_emiss_curr_per_floor_area: "20",
          co2_emissions_potential: "1.4",
          heating_cost_current: "365.98",
          heating_cost_potential: "250.34",
          hot_water_cost_current: "200.40",
          hot_water_cost_potential: "180.43",
          lighting_cost_current: "123.45",
          lighting_cost_potential: "84.23",
          total_floor_area: "55",
          mains_gas_flag: "Y",
          flat_top_storey: "N",
          flat_storey_count: 3,
          multi_glaze_proportion: "100",
          glazed_area: "Normal",
          number_habitable_rooms: 5,
          number_heated_rooms: 5,
          low_energy_lighting: "100",
          fixed_lighting_outlets_count: 16,
          low_energy_fixed_lighting_outlets_count: 16,
          number_open_fireplaces: 0,
          hotwater_description: "From main system",
          hot_water_energy_eff: "Good",
          hot_water_env_eff: "Good",
          wind_turbine_count: 0,
          heat_loss_corridor: "unheated corridor",
          unheated_corridor_length: "10",
          windows_description: "Fully double glazed",
          windows_energy_eff: "Average",
          windows_env_eff: "Average",
          secondheat_description: "Room heaters, electric",
          sheating_energy_eff: "N/A",
          sheating_env_eff: "N/A",
          lighting_description: "Low energy lighting in 50% of fixed outlets",
          lighting_energy_eff: "Good",
          lighting_env_eff: "Good",
          photo_supply: "0",
          built_form: "Semi-Detached",
          mainheat_description:
            "Boiler and radiators, anthracite, Boiler and radiators, mains gas",
          mainheat_energy_eff: "Average",
          mainheat_env_eff: "Very Poor",
          extension_count: 0,
          report_type: "2",
          mainheatcont_description: "Programmer, room thermostat and TRVs",
          roof_description: "Pitched, 25 mm loft insulation",
          roof_energy_eff: "Poor",
          roof_env_eff: "Poor",
          walls_description: "Solid brick, as built, no insulation (assumed)",
          walls_energy_eff: "Very Poor",
          walls_env_eff: "Very Poor",
          energy_tariff: "Single",
          floor_level: "01",
          solar_water_heating_flag: "N",
          mechanical_ventilation: "natural",
          floor_height: "2.45",
          main_fuel: "mains gas (not community)",
          floor_description: "Suspended, no insulation (assumed)",
          floor_energy_eff: "N/A",
          floor_env_eff: "N/A",
          mainheatc_energy_eff: "Good",
          mainheatc_env_eff: "Good",
          glazed_type: "double glazing installed during or after 2002",
        }
      end

      let(:additional_data) do
        {
          "address_id": "UPRN-0000000123",
        }
      end

      it "reads the appropriate values" do
        test_xml_doc(schemas, assertion, :to_report, additional_data)
      end
    end
  end
end
