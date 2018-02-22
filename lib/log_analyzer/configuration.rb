module LogAnalyzer

  class Configuration
    ALL      = 'A'.freeze # ALL
    PARTIALS = 'P'.freeze # Partials
    VIEWS    = 'V'.freeze # Views
    FILTERS  = Hash.new([PARTIALS, VIEWS]).merge({
      PARTIALS => [PARTIALS],
      VIEWS    => [VIEWS]
    }).freeze # with default value ALL

    class << self
      attr_accessor :configuration
    end

    attr_accessor :filter
    attr_reader   :filters

    def initialize
      @filter = ALL
    end

    def filter=(other)
      @filter    = other.upcase[0]
      @filters ||= FILTERS[filter]
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

  end
end