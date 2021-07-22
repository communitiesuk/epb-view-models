module ViewModel
  class BaseViewModel
    def initialize(xml_doc)
      @xml_doc = xml_doc
    end

    def xpath(queries, node = @xml_doc)
      queries.each do |query|
        if node
          node = node.at query
        else
          return nil
        end
      end
      node ? node.content : nil
    end
  end
end
