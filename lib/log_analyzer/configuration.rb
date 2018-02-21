module LogAnalyzer

  class Configuration
    ALL      = 'A'.freeze # ALL
    PARTIALS = 'P'.freeze # Partials
    VIEWS    = 'V'.freeze # Views

    class << self
      attr_accessor :configuration
    end

    attr_accessor :filter

    def initialize
      @filter = ALL
    end

    def filter=(other)
      @filter = other.upcase[0]
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    def filters
      @filters ||= case filter
      when VIEWS
        [VIEWS]
      when PARTIALS
        [PARTIALS]
      else
        [PARTIALS, VIEWS]
      end
    end

  end

end