module ReconDatabase
  class SolveTime
    class << self
      def field_name
        "Time"
      end

      def queryer_html(params)
        ERB.new(File.read("views/input.erb")).result(binding)
      end

      def filter(result, params)
        specifier = params["time-specifier"]
        value = params["time-value"]
        unless specifier.blank? || value.blank?
          result.where("time #{sign_for specifier} ?", value) 
        else
          result
        end
      end

      def sign_for(specifier)
        case specifier
        when "less"
          "<"
        when "greater"
          ">"
        when "equal"
          "="
        end
      end
    end
  end
end
