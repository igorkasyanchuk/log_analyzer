module LogAnalyzer

  class Analyzer
    DEFAULT_TABLE_WIDTH = 120 # width
    MATCHER             = /Rendered (.*\/.*) \((.*)ms\)/.freeze
    DANGER_DEFAULT      = 800 # ms
    WARNING_DEFAULT     = 400 # ms
    INFO_DEFAULT        = 100 # ms
    HEADER              = ['View', 'Count', 'AVG (ms)', 'Max', 'Min'].freeze

    attr_reader :filename
    attr_reader :stats

    def initialize(filename:)
      @filename = filename
      @stats    = {}
    end

    def run
      IO.foreach(filename).each do |line|
        if line =~ MATCHER
          if $1 && $2
            @stats[$1] ||= Stat.new
            @stats[$1].push($2)
          end
        end
      end
    end

    def order(by: :time)
      case by.to_sym
      when :name
        @stats = @stats.sort{|a, b| a[0] <=> b[0] }
      when :time
        @stats = @stats.sort{|a, b| a[1].avg <=> b[1].avg }
      when :count
        @stats = @stats.sort{|a, b| a[1].count <=> b[1].count }
      end
    end

    def visualize(limit: 100)
      length = (0..DEFAULT_TABLE_WIDTH - 20).freeze
      table  = Terminal::Table.new \
        headings: HEADER,
        width: DEFAULT_TABLE_WIDTH do |t|
          stats.each do |path, stat|
            t.add_row [
              path[length],
              stat.count,
              avg_label(stat.avg),
              stat.max,
              stat.min,
            ]
          end
          t.add_separator
          t.add_row(HEADER)
      end
      puts table
    end

    def avg_label(avg)
      str = avg.to_s
      if avg > DANGER_DEFAULT
        str.white.on_red
      elsif avg > WARNING_DEFAULT
        str.red
      elsif avg > INFO_DEFAULT
        str.yellow
      else
        str.green
      end
    end
  end
end