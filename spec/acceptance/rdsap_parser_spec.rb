RSpec.describe "the parser and the rdsap configuration" do
  context "when loading xml from RdSap" do
    let(:config) do
      Presenter::RdSap::ExportConfiguration.new
    end

    let(:parser) do
      Presenter::Xml::Parser.new(**config.to_args)
    end

    let(:rdsap) do
      Samples.xml("RdSAP-Schema-20.0.0")
    end

    it "parses the document in the expected format" do
      expect { parser.parse(rdsap) }.not_to raise_error
    end

    context "when parsing RdSAP-Schema-21.0.0" do
      let(:rdsap) do
        Samples.xml("RdSAP-Schema-21.0.0")
      end

      it "parses the document in the expected format" do
        expect { parser.parse(rdsap) }.not_to raise_error
      end
    end
  end
end
