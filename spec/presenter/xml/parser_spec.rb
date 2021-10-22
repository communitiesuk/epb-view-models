RSpec.describe Presenter::Xml::Parser do
  context "with no configuration" do
    it "maps simple XML (with no multiples) to a hash structure" do
      xml = "<Opening><Node-1>value 1</Node-1><Node-2>value 2</Node-2></Opening>"
      expected = {
        "node_1" => "value 1",
        "node_2" => "value 2",
      }
      expect(described_class.new.parse(xml)).to eq expected
    end
  end

  context "with bases defined" do
    let(:parser) { described_class.new bases: %w[Base] }

    it "pulls up nodes under bases into same level as base" do
      xml = "<Root><Id>ID123</Id><Base><Node-1>value 1</Node-1><Node-2>value 2</Node-2></Base></Root>"
      expected = {
        "id" => "ID123",
        "node_1" => "value 1",
        "node_2" => "value 2",
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with nodes excluded" do
    let(:parser) { described_class.new excludes: %w[Node-2] }

    it "excludes XML node names from mapping into output data structure" do
      xml = "<Root><Id>ID123</Id><Node-1>value 1</Node-1><Node-2>value 2</Node-2><Node-3>value 3</Node-3></Root>"
      expected = {
        "id" => "ID123",
        "node_1" => "value 1",
        "node_3" => "value 3",
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with nodes included on top of excludes" do
    let(:parser) { described_class.new excludes: %w[Exclude], includes: %w[Include-Me] }

    it "excludes XML nodes under an exclude but including any includes within it" do
      xml = "<Root><Id>ID123</Id><Exclude><Assessment-Id>ID456</Assessment-Id><Include-Me>me!</Include-Me></Exclude></Root>"
      expected = {
        "id" => "ID123",
        "include_me" => "me!",
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with preferred keys given" do
    let(:parser) { described_class.new preferred_keys: { "Internal-Name" => "external_name" } }

    it "uses a preferred key when given a node name that has one" do
      xml = "<Root><Id>ID123</Id><Internal-Name>blue</Internal-Name></Root>"
      expected = {
        "id" => "ID123",
        "external_name" => "blue",
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with a list of nodes within a reasonable deep hierarchy" do
    let(:parser) { described_class.new }

    it "recognises a list and maps it into the data structure" do
      xml = "<Root><Subject><Sub-Subject><Rooms><Room><Id>ROOM1</Id><Name>Room 1</Name></Room><Room><Id>ROOM2</Id><Name>Room 2</Name></Room></Rooms></Sub-Subject></Subject></Root>"
      expected = {
        "subject" => {
          "sub_subject" => {
            "rooms" => [
              {
                "id" => "ROOM1",
                "name" => "Room 1",
              },
              {
                "id" => "ROOM2",
                "name" => "Room 2",
              },
            ],
          },
        },
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with node values containing numeric values" do
    let(:parser) { described_class.new }

    it "recognises values that can be numbers and maps them to floats or integers depending on decimal point" do
      xml = "<Root><Not-Quite-Numeric>123ABC</Not-Quite-Numeric><Floaty>13.45</Floaty><Inty>42</Inty></Root>"
      expected = {
        "not_quite_numeric" => "123ABC",
        "floaty" => 13.45,
        "inty" => 42,
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with nodes containing attributes" do
    let(:parser) { described_class.new }

    it "maps these nodes as a hash containing the node's attributes plus a value attribute with the value" do
      xml = '<Root><Money-Amount currency="GBP">139.99</Money-Amount></Root>'
      expected = {
        "money_amount" => {
          "currency" => "GBP",
          "value" => 139.99,
        },
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with list nodes specified" do
    let(:parser) { described_class.new list_nodes: ["Actually-A-List"] }

    it "treats given list node as a list, even if there is only one item in the list" do
      xml = "<Root><Implicit-List><Implicit-Item><Id>123</Id></Implicit-Item><Implicit-Item><Id>456</Id></Implicit-Item></Implicit-List><Actually-A-List><Actually-An-Item><Speech>I am in a list!</Speech></Actually-An-Item></Actually-A-List></Root>"
      expected = {
        "implicit_list" => [
          {
            "id" => 123,
          },
          {
            "id" => 456,
          },
        ],
        "actually_a_list" => [
          {
            "speech" => "I am in a list!",
          },
        ],
      }
      expect(parser.parse(xml)).to eq expected
    end
  end

  context "with list nodes specified that are nested within other lists" do
    let(:parser) { described_class.new list_nodes: %w[Outer-List Inner-List] }

    it "can map nested lists" do
      xml = "<Root><Outer-List><Item><Inner-List><Item><Name>I am in a list!</Name></Item></Inner-List></Item></Outer-List></Root>"
      expected = {
        "outer_list" => [
          {
            "inner_list" => [
              {
                "name" => "I am in a list!",
              },
            ],
          },
        ],
      }
      expect(parser.parse(xml)).to eq expected
    end
  end
end
