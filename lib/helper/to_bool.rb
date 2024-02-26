module Helper
  class ToBool
    def self.execute(string)
      case string
      when "true"
        true
      when "false"
        false
      end
    end
  end
end
