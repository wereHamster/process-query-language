
module ProcessQueryLanguage

  class Matcher

    attr_reader :pattern

    # pattern: { a => { $gt => 100 }, b => { $in => [ 1,2,3 ] } }
    def initialize(pattern)
      @pattern = pattern
    end

    def apply(op, value, pattern)
      case op
      when "$gt"
        return value > pattern
      when "$gte"
        return value >= pattern
      when "$lt"
        return value < pattern
      when "$lte"
        return value <= pattern
      when "$in"
        return pattern.include?(value)
      when "$nin"
        return !pattern.include?(value)
      else
        raise Exception.new("Unknown operator: #{op}")
      end
    end

    # object: { a => 200, b => 2 }
    def match(object)
      pattern.each do |key, value|
        return false if object[key].nil?

        case value
        when Regexp
          return false if !value.match(object[key])
        when Hash
          value.each do |op, value|
            return false if !apply(op, object[key], value)
          end
        when object[key]
          return false if object[key] != value
        else
          return false
        end
      end

      return true
    end

  end

end
