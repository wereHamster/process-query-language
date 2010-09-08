
module ProcessQueryLanguage

  class Collection

    def initialize(backend)
      @backend = backend
    end

    def find(query, options)
      query[:pid] = query.delete(:_id) if query[:_id]

      keys = query.keys
      keys = keys + options[:fields] if options[:fields]

      matcher = ProcessQueryLanguage::Matcher.new(query)
      result = []
      @backend.scan(keys.uniq).each do |process|
        if matcher.match(process)
          result << process
        end
      end

      return result
    end

    def find_one(query, options)
      find(query, options).first
    end

    def remove(query)
      find(query, { :fields => [ :pid ] }).each do |process|
        Process.kill(process[:pid])
      end
    end

    def insert
    end

  end

end
