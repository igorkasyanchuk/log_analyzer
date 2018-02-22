module LogAnalyzer

  class Analyzer
    DEFAULT_TABLE_WIDTH = 120 # width
    MATCHER             = /Rendered (.*\/.*) \((.*)ms\)/.freeze
    DANGER_DEFAULT      = 800 # ms
    WARNING_DEFAULT     = 400 # ms
    INFO_DEFAULT        = 100 # ms
    HEADER              = ['Type', 'View', 'Count', 'AVG (ms)', 'Max', 'Min'].freeze
    PARTIAL_LABEL       = " P ".on_green.black.freeze
    VIEW_LABEL          = " V ".on_yellow.black.freeze

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
            view = $1
            @stats[view] ||= Stat.new(type: find_type(view))
            @stats[view].push($2)
          end
        end
      end
    end

    def find_type(view)
      view.split('/'.freeze).last[0] == '_' ? 'P'.freeze : 'V'.freeze
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

    def visualize(limit: 100, short_paths: false)
      length  = (0..DEFAULT_TABLE_WIDTH - 20).freeze
      filters = LogAnalyzer::Configuration.configuration.filters
      table   = Terminal::Table.new \
        headings: HEADER,
        width: DEFAULT_TABLE_WIDTH do |t|
          stats.each do |path, stat|
            next unless filters.include?(stat.type)
            path_to_display = short_paths ? PathShortener.shrink(path, max: length.last) : path[length]
            t.add_row [
              type_label(stat.type),
              path_to_display,
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

    private

      def type_label(type)
        type == LogAnalyzer::Configuration::PARTIALS ? PARTIAL_LABEL : VIEW_LABEL
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
