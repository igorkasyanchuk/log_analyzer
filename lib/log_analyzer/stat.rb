module LogAnalyzer
  class Stat
    attr_reader :data

    def initialize
      @data  = []
    end
    
    def count
      @data.count
    end

    def push(time)
      @data << time.to_f
    end

    def avg
      @avg ||= (sum.to_f / count.to_f).round(2)
    end

    def max; @max ||= @data.max; end
    def min; @min ||= @data.min; end

    private
    def sum
      @sum ||= @data.reduce(:+)
    end
  end
end
