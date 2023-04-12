module Helper
  class XmlEnumsToOutput
    RATINGS = {
      "0" => "N/A",
      "1" => "Very Poor",
      "2" => "Poor",
      "3" => "Average",
      "4" => "Good",
      "5" => "Very Good",
    }.freeze
    BUILT_FORM = {
      "1" => "Detached",
      "2" => "Semi-Detached",
      "3" => "End-Terrace",
      "4" => "Mid-Terrace",
      "5" => "Enclosed End-Terrace",
      "6" => "Enclosed Mid-Terrace",
      "7" => "Linked Detached",
      "NR" => "Not Recorded",
    }.freeze
    SAP_ENERGY_TARIFF = {
      "1" => "standard tariff",
      "2" => "off-peak 7 hour",
      "3" => "off-peak 10 hour",
      "4" => "24 hour",
      "ND" => "not applicable",
    }.freeze
    RDSAP_ENERGY_TARIFF = {
      "1" => "dual",
      "2" => "Single",
      "3" => "Unknown",
      "4" => "dual (24 hour)",
      "5" => "off-peak 18 hour",
    }.freeze
    RDSAP_GLAZED_TYPE = {
      "1" => "double glazing installed before 2002",
      "2" => "double glazing installed during or after 2002",
      "3" => "double glazing, unknown install date",
      "4" => "secondary glazing",
      "5" => "single glazing",
      "6" => "triple glazing",
      "7" => "double, known data",
      "8" => "triple, known data",
      "ND" => "not defined",
    }.freeze
    RDSAP_GLAZED_AREA = {
      "1" => "Normal",
      "2" => "More Than Typical",
      "3" => "Less Than Typical",
      "4" => "Much More Than Typical",
      "5" => "Much Less Than Typical",
      "ND" => "Not Defined",
    }.freeze
    TENURE = {
      "1" => "Owner-occupied",
      "2" => "Rented (social)",
      "3" => "Rented (private)",
      "ND" =>
        "Not defined - use in the case of a new dwelling for which the intended tenure in not known. It is not to be used for an existing dwelling",
    }.freeze
    TRANSACTION_TYPE = {
      "1" => "marketed sale",
      "2" => "non marketed sale",
      "3" =>
        "rental (social) - this is for backwards compatibility only and should not be used",
      "4" =>
        "rental (private) - this is for backwards compatibility only and should not be used",
      "5" => "not sale or rental",
      "ni_5" => "None of the above",
      "6" => "new dwelling",
      "7" =>
        "not recorded - this is for backwards compatibility only and should not be used",
      "8" => "rental",
      "9" => "assessment for green deal",
      "10" => "following green deal",
      "11" => "FiT application",
      "12" => "Stock condition survey",
      "12RdSAP" => "RHI application",
      "13RdSAP" => "ECO assessment",
      "14RdSAP" => "Stock condition survey",
    }.freeze
    CONSTRUCTION_AGE_BAND = {
      "A" => "England and Wales: before 1900",
      "B" => "England and Wales: 1900-1929",
      "C" => "England and Wales: 1930-1949",
      "D" => "England and Wales: 1950-1966",
      "E" => "England and Wales: 1967-1975",
      "F" => "England and Wales: 1976-1982",
      "G" => "England and Wales: 1983-1990",
      "H" => "England and Wales: 1991-1995",
      "I" => "England and Wales: 1996-2002",
      "J" => "England and Wales: 2003-2006",
      "K" => "England and Wales: 2007-2011",
      "K-pre-17.0" => "England and Wales: 2007 onwards",
      "K-12.0" => "Post-2006",
      "L" => "England and Wales: 2012 onwards",
      "0" => "Not applicable",
      "NR" => "Not recorded",
    }.freeze
    CONSTRUCTION_AGE_BAND_NI = {
      "A" => "Northern Ireland: before 1919",
      "A-12.0" => "Pre-1900",
      "B" => "Northern Ireland: 1919-1929",
      "B-12.0" => "1900-1929",
      "C" => "Northern Ireland: 1930-1949",
      "C-12.0" => "1930-1949",
      "D" => "Northern Ireland: 1950-1973",
      "D-12.0" => "1950-1966",
      "E" => "Northern Ireland: 1974-1977",
      "E-12.0" => "1967-1975",
      "F" => "Northern Ireland: 1978-1985",
      "F-12.0" => "1976-1982",
      "G" => "Northern Ireland: 1986-1991",
      "G-12.0" => "1983-1990",
      "H" => "Northern Ireland: 1992-1999",
      "H-12.0" => "1991-1995",
      "I" => "Northern Ireland: 2000-2006",
      "I-12.0" => "1996-2002",
      "J" => "Northern Ireland: not applicable",
      "J-12.0" => "2003-2006",
      "K-RdSAP-NI" => "Northern Ireland: 2007-2013",
      "K-SAP-NI" => "Northern Ireland: 2007 onwards",
      "K-12.0" => "Post-2006",
      "L" => "Northern Ireland: 2014 onwards",
      "0" => "Not applicable",
      "NR" => "Not recorded",
    }.freeze
    PROPERTY_TYPE = {
      "0" => "House",
      "1" => "Bungalow",
      "2" => "Flat",
      "3" => "Maisonette",
      "4" => "Park home",
    }.freeze
    HEAT_LOSS_CORRIDOR = {
      "0" => "no corridor",
      "1" => "heated corridor",
      "2" => "unheated corridor",
    }.freeze
    MECHANICAL_VENTILATION = {
      "0" => "natural",
      "1" => "mechanical, supply and extract",
      "2" => "mechanical, extract only",
      "0-pre12.0" => "none",
      "1-pre12.0" => "mechanical - heat recovering",
      "2-pre12.0" => "mechanical - non recovering",
    }.freeze
    CEPC_TRANSACTION_TYPE = {
      "1" => "Mandatory issue (Marketed sale)",
      "2" => "Mandatory issue (Non-marketed sale)",
      "3" => "Mandatory issue (Property on construction).",
      "4" => "Mandatory issue (Property to let).",
      "5" => "Voluntary re-issue (A valid EPC is already lodged).",
      "6" => "Voluntary (No legal requirement for an EPC).",
      "7" => "Not recorded.",
    }.freeze
    VENTILATION_TYPE = {
      "1" => "natural with intermittent extract fans",
      "2" => "natural with passive vents",
      "3" => "positive input from loft",
      "4" => "positive input from outside",
      "5" => "mechanical extract, centralised (MEV c)",
      "6" => "mechanical extract, decentralised (MEV dc)",
      "7" => "balanced without heat recovery (MV)",
      "8" => "balanced with heat recovery (MVHR)",
      "9" => "natural with intermittent extract fans and/or passive vents. For backwards compatibility only, do not use.",
      "10" => "natural with intermittent extract fans and passive vents",
    }.freeze
    CYLINDER_INSULATION_THICKNESS = {
      "12" => "12 mm",
      "25" => "25 mm",
      "38" => "38 mm",
      "50" => "50 mm",
      "80" => "80 mm",
      "120" => "120 mm",
      "160" => "160 mm",
    }.freeze
    RDSAP_FUEL_TYPE = {
      "0" => "To be used only when there is no heating/hot-water system or data is from a community network",
      "1" => "mains gas - this is for backwards compatibility only and should not be used",
      "2" => "LPG - this is for backwards compatibility only and should not be used",
      "3" => "bottled LPG",
      "4" => "oil - this is for backwards compatibility only and should not be used",
      "5" => "anthracite",
      "6" => "wood logs",
      "7" => "bulk wood pellets",
      "8" => "wood chips",
      "9" => "dual fuel - mineral + wood",
      "10" => "electricity - this is for backwards compatibility only and should not be used",
      "11" => "waste combustion - this is for backwards compatibility only and should not be used",
      "12" => "biomass - this is for backwards compatibility only and should not be used",
      "13" => "biogas - landfill - this is for backwards compatibility only and should not be used",
      "14" => "house coal - this is for backwards compatibility only and should not be used",
      "15" => "smokeless coal",
      "16" => "wood pellets in bags for secondary heating",
      "17" => "LPG special condition",
      "18" => "B30K (not community)",
      "19" => "bioethanol",
      "20" => "mains gas (community)",
      "21" => "LPG (community)",
      "22" => "oil (community)",
      "23" => "B30D (community)",
      "24" => "coal (community)",
      "25" => "electricity (community)",
      "26" => "mains gas (not community)",
      "27" => "LPG (not community)",
      "28" => "oil (not community)",
      "29" => "electricity (not community)",
      "30" => "waste combustion (community)",
      "31" => "biomass (community)",
      "32" => "biogas (community)",
      "33" => "house coal (not community)",
      "34" => "biodiesel from any biomass source",
      "35" => "biodiesel from used cooking oil only",
      "36" => "biodiesel from vegetable oil only (not community)",
      "36-rapeseed-oil" => "rapeseed oil",
      "37" => "appliances able to use mineral oil or liquid biofuel",
      "51" => "biogas (not community)",
      "56" => "heat from boilers that can use mineral oil or biodiesel (community)",
      "57" => "heat from boilers using biodiesel from any biomass source (community)",
      "58" => "biodiesel from vegetable oil only (community)",
      "99" => "from heat network data (community)",
    }.freeze
    RDSAP_FUEL_TYPE_PRE_143 = {
      "1-pre14.3-sap" => "mains gas",
      "4-pre14.3-sap" => "oil",
      "10-pre14.3-sap" => "electricity",
      "11-pre14.3-sap" => "waste combustion",
      "12-pre14.3-sap" => "biomass",
      "13-pre14.3-sap" => "biogas - landfill",
      "14-pre14.3-sap" => "house coal",
    }.freeze
    SAP_FUEL_TYPE = {
      "1" => "Gas: mains gas",
      "2" => "Gas: bulk LPG",
      "3" => "Gas: bottled LPG",
      "4" => "Oil: heating oil",
      "7" => "Gas: biogas",
      "8" => "LNG",
      "9" => "LPG subject to Special Condition 18",
      "10" => "Solid fuel: dual fuel appliance (mineral and wood)",
      "11" => "Solid fuel: house coal",
      "12" => "Solid fuel: manufactured smokeless fuel",
      "15" => "Solid fuel: anthracite",
      "20" => "Solid fuel: wood logs",
      "21" => "Solid fuel: wood chips",
      "22" => "Solid fuel: wood pellets (in bags, for secondary heating)",
      "23" => "Solid fuel: wood pellets (bulk supply in bags, for main heating)",
      "36" => "Electricity: electricity sold to grid",
      "37" => "Electricity: electricity displaced from grid",
      "39" => "Electricity: electricity, unspecified tariff",
      "41" => "Community heating schemes: heat from electric heat pump",
      "42" => "Community heating schemes: heat from boilers - waste combustion",
      "43" => "Community heating schemes: heat from boilers - biomass",
      "44" => "Community heating schemes: heat from boilers - biogas",
      "45" => "Community heating schemes: waste heat from power stations",
      "46" => "Community heating schemes: geothermal heat source",
      "48" => "Community heating schemes: heat from CHP",
      "49" => "Community heating schemes: electricity generated by CHP",
      "50" => "Community heating schemes: electricity for pumping in distribution network",
      "51" => "Community heating schemes: heat from mains gas",
      "52" => "Community heating schemes: heat from LPG",
      "53" => "Community heating schemes: heat from oil",
      "54" => "Community heating schemes: heat from coal",
      "55" => "Community heating schemes: heat from B30D",
      "56" => "Community heating schemes: heat from boilers that can use mineral oil or biodiesel",
      "57" => "Community heating schemes: heat from boilers using biodiesel from any biomass source",
      "58" => "Community heating schemes: biodiesel from vegetable oil only",
      "71" => "biodiesel from any biomass source",
      "72" => "biodiesel from used cooking oil only",
      "73" => "biodiesel from vegetable oil only",
      "74" => "appliances able to use mineral oil or liquid biofuel",
      "75" => "B30K",
      "76" => "bioethanol from any biomass source",
      "99" => "Community heating schemes: special fuel",
    }.freeze
    MAIN_HEATING_CATEGORY = {
      "1" => "none",
      "2" => "boiler with radiators or underfloor heating",
      "3" => "micro-cogeneration",
      "4" => "heat pump with radiators or underfloor heating",
      "5" => "heat pump with warm air distribution",
      "6" => "community heating system",
      "7" => "electric storage heaters",
      "8" => "electric underfloor heating",
      "9" => "warm air system (not heat pump)",
      "10" => "room heaters",
      "11" => "other system",
      "12" => "not recorded",
    }.freeze

    def self.built_form_string(number)
      BUILT_FORM[number]
    end

    def self.energy_rating_string(value)
      RATINGS[value]
    end

    def self.energy_tariff(value, report_type)
      if is_sap(report_type)
        SAP_ENERGY_TARIFF[value] || value
      elsif is_rdsap(report_type)
        RDSAP_ENERGY_TARIFF[value] || value
      else
        value
      end
    end

    def self.glazed_area_rdsap(value)
      RDSAP_GLAZED_AREA[value]
    end

    def self.glazed_type_rdsap(value)
      RDSAP_GLAZED_TYPE[value]
    end

    def self.tenure(value)
      TENURE[value] || value
    end

    def self.transaction_type(value, report_type = "2", schema_type = "")
      types_of_ni = %i[
        RdSAP-Schema-NI-20.0.0
        RdSAP-Schema-NI-19.0
        RdSAP-Schema-NI-18.0
        RdSAP-Schema-NI-17.4
        RdSAP-Schema-NI-17.3
        SAP-Schema-NI-16.1
        SAP-Schema-NI-17.0
        SAP-Schema-NI-17.1
        SAP-Schema-NI-17.2
        SAP-Schema-NI-17.3
        SAP-Schema-NI-17.4
        SAP-Schema-NI-18.0.0
      ]

      if is_rdsap(report_type) && value.to_i >= 12
        TRANSACTION_TYPE["#{value}RdSAP"]
      elsif types_of_ni.include?(schema_type) && value.to_i == 5
        TRANSACTION_TYPE["ni_5"]
      else
        TRANSACTION_TYPE[value] || value
      end
    end

    def self.construction_age_band_lookup(value, schema_type, report_type)
      types_of_sap_pre17 = %i[
        SAP-Schema-16.3
        SAP-Schema-16.2
        SAP-Schema-16.1
        SAP-Schema-16.0
        SAP-Schema-15.0
        SAP-Schema-14.2
        SAP-Schema-14.1
        SAP-Schema-14.0
        SAP-Schema-13.0
        SAP-Schema-12.0
        SAP-Schema-11.2
        SAP-Schema-11.0
      ].freeze

      schemes_that_use_not_recorded = %i[
        SAP-Schema-16.3
        SAP-Schema-16.2
        SAP-Schema-16.1
        RdSAP-Schema-20.0.0
        RdSAP-Schema-19.0
        RdSAP-Schema-18.0
        RdSAP-Schema-17.1
        RdSAP-Schema-17.0
      ]

      schemes_that_use_l = %i[
        SAP-Schema-19.1.0
        SAP-Schema-19.0.0
        SAP-Schema-18.0.0
        SAP-Schema-17.1
        SAP-Schema-17.0
        RdSAP-Schema-20.0.0
        RdSAP-Schema-19.0
        RdSAP-Schema-18.0
        RdSAP-Schema-17.1
        RdSAP-Schema-17.0
      ]

      schemes_that_use_0 = %i[
        SAP-Schema-16.3
        SAP-Schema-16.2
        SAP-Schema-16.1
        SAP-Schema-16.0
        SAP-Schema-15.0
        SAP-Schema-14.2
        SAP-Schema-14.1
        SAP-Schema-14.0
        SAP-Schema-13.0
        SAP-Schema-12.0
        RdSAP-Schema-20.0.0
        RdSAP-Schema-19.0
        RdSAP-Schema-18.0
        RdSAP-Schema-17.1
        RdSAP-Schema-17.0
      ]

      sap_schemas_ni = %i[
        SAP-Schema-NI-18.0.0
        SAP-Schema-NI-17.4
        SAP-Schema-NI-17.3
        SAP-Schema-NI-17.2
        SAP-Schema-NI-17.1
        SAP-Schema-NI-17.0
        SAP-Schema-NI-16.1
        SAP-Schema-NI-16.0
        SAP-Schema-NI-15.0
        SAP-Schema-NI-14.2
        SAP-Schema-NI-14.1
        SAP-Schema-NI-14.0
        SAP-Schema-NI-13.0
      ]

      rdsap_schemas_ni = %i[
        RdSAP-Schema-NI-20.0.0
        RdSAP-Schema-NI-19.0
        RdSAP-Schema-NI-18.0
        RdSAP-Schema-NI-17.4
        RdSAP-Schema-NI-17.3
      ]

      ni_schemas_pre_12 = %i[
        SAP-Schema-NI-12.0
        SAP-Schema-NI-11.2
      ]

      if value == "K" && rdsap_schemas_ni.include?(schema_type)
        return CONSTRUCTION_AGE_BAND_NI["K-RdSAP-NI"] || value
      end

      if value == "K" && sap_schemas_ni.include?(schema_type)
        return CONSTRUCTION_AGE_BAND_NI["K-SAP-NI"] || value
      end

      if ni_schemas_pre_12.include?(schema_type)
        key = (value == "0" ? value : "#{value}-12.0")
        return CONSTRUCTION_AGE_BAND_NI[key] || value
      end

      if sap_schemas_ni.include?(schema_type) || rdsap_schemas_ni.include?(schema_type)
        return CONSTRUCTION_AGE_BAND_NI[value] || value
      end

      if value == "K" && schema_type == :"SAP-Schema-12.0" && is_rdsap(report_type)
        return CONSTRUCTION_AGE_BAND["K-12.0"]
      end

      if value == "K" && types_of_sap_pre17.include?(schema_type)
        return CONSTRUCTION_AGE_BAND["K-pre-17.0"]
      end

      if value == "NR" &&
          (!schemes_that_use_not_recorded.include?(schema_type) || is_sap(report_type))
        return value
      end

      return value if value == "L" && !schemes_that_use_l.include?(schema_type)

      if value == "0" &&
          (!schemes_that_use_0.include?(schema_type) || is_sap(report_type))
        return value
      end

      value == "" ? nil : CONSTRUCTION_AGE_BAND[value] || value
    end

    def self.property_type(value)
      PROPERTY_TYPE[value] || value
    end

    def self.heat_loss_corridor(value)
      HEAT_LOSS_CORRIDOR[value] || value
    end

    def self.mechanical_ventilation(value, schema_type, report_type)
      types_of_sap_pre12 = %i[
        SAP-Schema-11.2
        SAP-Schema-11.0
        SAP-Schema-10.2
        SAP-Schema-NI-11.2
      ].freeze
      if types_of_sap_pre12.include?(schema_type) && is_rdsap(report_type)
        return MECHANICAL_VENTILATION["#{value}-pre12.0"]
      end

      MECHANICAL_VENTILATION[value] || value
    end

    def self.cepc_transaction_type(value)
      CEPC_TRANSACTION_TYPE[value] || value
    end

    def self.cylinder_insulation_thickness(value, report_type = "2")
      if is_rdsap(report_type)
        CYLINDER_INSULATION_THICKNESS[value]
      else
        value
      end
    end

    def self.is_rdsap(report_type)
      report_type == "2"
    end

    def self.is_sap(report_type)
      report_type == "3"
    end

    def self.ventilation_type(value, schema_type = "")
      ni_sap = %i[
        SAP-Schema-NI-16.1
        SAP-Schema-NI-16.0
        SAP-Schema-NI-15.0
        SAP-Schema-NI-14.2
        SAP-Schema-NI-14.1
        SAP-Schema-NI-14.0
        SAP-Schema-NI-13.0
      ].freeze

      if ni_sap.include?(schema_type) && value == "9"
        VENTILATION_TYPE[value].split(".").first
      else
        VENTILATION_TYPE[value]
      end
    end

    def self.fuel_type(value, schema_type = "", report_type = "2")
      rdsap = %i[
        RdSAP-Schema-20.0.0
        RdSAP-Schema-19.0
        RdSAP-Schema-18.0
        RdSAP-Schema-17.1
        RdSAP-Schema-17.0
        RdSAP-Schema-NI-20.0.0
        RdSAP-Schema-NI-19.0
        RdSAP-Schema-NI-18.0
        RdSAP-Schema-NI-17.4
        RdSAP-Schema-NI-17.3
      ]

      pre143_sap = %i[
        SAP-Schema-14.2
        SAP-Schema-14.1
        SAP-Schema-14.0
        SAP-Schema-13.0
        SAP-Schema-12.0
        SAP-Schema-11.2
        SAP-Schema-11.0
        SAP-Schema-10.2
        SAP-Schema-NI-14.2
        SAP-Schema-NI-14.1
        SAP-Schema-NI-14.0
        SAP-Schema-NI-13.0
        SAP-Schema-NI-12.0
        SAP-Schema-NI-11.2
      ]

      includes_rapeseed_oil = %i[
        SAP-Schema-16.3
        SAP-Schema-16.2
        SAP-Schema-16.1
        SAP-Schema-16.0
        SAP-Schema-15.0
        SAP-Schema-NI-17.2
        SAP-Schema-NI-17.1
        SAP-Schema-NI-17.0
        SAP-Schema-NI-16.1
        SAP-Schema-NI-16.0
        SAP-Schema-NI-15.0
      ]

      sap = %i[
        SAP-Schema-19.1.0
        SAP-Schema-19.0.0
        SAP-Schema-18.0.0
        SAP-Schema-17.1
        SAP-Schema-17.0
        SAP-Schema-16.3
        SAP-Schema-16.2
        SAP-Schema-16.1
        SAP-Schema-16.0
        SAP-Schema-15.0
        SAP-Schema-14.2
        SAP-Schema-14.1
        SAP-Schema-14.0
        SAP-Schema-13.0
        SAP-Schema-12.0
        SAP-Schema-11.2
        SAP-Schema-11.0
        SAP-Schema-10.2
        SAP-Schema-NI-18.0.0
        SAP-Schema-NI-17.4
        SAP-Schema-NI-17.3
        SAP-Schema-NI-17.2
        SAP-Schema-NI-17.1
        SAP-Schema-NI-17.0
        SAP-Schema-NI-16.1
        SAP-Schema-NI-16.0
        SAP-Schema-NI-15.0
        SAP-Schema-NI-14.2
        SAP-Schema-NI-14.1
        SAP-Schema-NI-14.0
        SAP-Schema-NI-13.0
        SAP-Schema-NI-12.0
        SAP-Schema-NI-11.2
      ]

      if rdsap.include?(schema_type)
        RDSAP_FUEL_TYPE[value]
      elsif sap.include?(schema_type) && is_sap(report_type)
        SAP_FUEL_TYPE[value]
      elsif sap.include?(schema_type) && is_rdsap(report_type)
        if includes_rapeseed_oil.include?(schema_type) && value == "36"
          return RDSAP_FUEL_TYPE["#{value}-rapeseed-oil"]
        end

        if pre143_sap.include?(schema_type)
          RDSAP_FUEL_TYPE_PRE_143["#{value}-pre14.3-sap"] || RDSAP_FUEL_TYPE[value]
        else
          RDSAP_FUEL_TYPE[value]
        end
      end
    end

    def self.main_heating_category(value:)
      MAIN_HEATING_CATEGORY[value] || value
    end

    private_class_method :is_rdsap, :is_sap
  end
end
