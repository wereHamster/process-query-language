
module ProcessQueryLanguage

  module Backend

    # This backend uses the `ps` utility and parses its output. Because
    # `ps` uses whitespace as the delimiter (and truncates too wide fields)
    # except the last, we need to sort the fields so that :command is
    # the last.
    class ProcessStatus

      FIELDS = %w{ pid rss command }.map(&:to_sym)

      def scan(fields)
        result = []
        %x[ps -Ao #{FIELDS.join(',')}].lines.to_a[1..-1].each do |line|
          values = line.split(' ')
          process = {}
          FIELDS.each_with_index do |value, i|
            next unless fields.include?(FIELDS[i])
            process[FIELDS[i]] = convert(FIELDS[i], values[i])
          end
          result << process
        end

        return result
      end

    private

      def convert(field, value)
        case field
        when :rss, :pid
          return value.to_i
        when :command
          return value.to_s
        else
          return nil
          raise Exception.new("Don't know how to convert #{field}")
        end
      end

    end

  end

end
