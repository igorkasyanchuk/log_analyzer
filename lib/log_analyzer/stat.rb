module LogAnalyzer
  class Stat
    attr_reader :count
    attr_reader :data

    def initialize
      @data  = []
      @count = 0
    end

    def push(time)
      @count += 1
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
