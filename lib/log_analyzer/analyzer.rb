module LogAnalyzer
  
  class Analyzer
    DEFAULT_TABLE_WIDTH = 120 # width
    CONTENT_LENGTH      = (0..DEFAULT_TABLE_WIDTH - 20).freeze
    ROWS_FOR_FOOTER     = 10
    HEADER              = ['Type', 'View', 'Count', 'AVG (ms)', 'Max', 'Min'].freeze
    MATCHER             = /Rendered (.*\/.*) \((.*)ms\)/.freeze

    attr_reader :filename
    attr_reader :stats

    def initialize(filename:)
      @filename = filename
      @stats    = {}
    end

    def run
      IO.foreach(filename).each do |line|
        if line.scrub =~ MATCHER
          if $1 && $2
            view = $1
            @stats[view] ||= Stat.new(type: Utils.find_type(view))
            @stats[view].push($2)
          end
        end
      end
    rescue Errno::ENOENT
      puts "File <#{filename}> is not found or inaccessible.".red
      exit
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

    def visualize(limit: 100, short: false)
      table      = new_table
      rows_count = 0

      # preparing report
      stats.each do |path, stat|
        next unless LogAnalyzer.configuration.filters.include?(stat.type)

        table.add_row format_row(path, stat, short)

        rows_count += 1
      end

      # adding a footer
      if rows_count > ROWS_FOR_FOOTER
        table.add_separator
        table.add_row(HEADER)
      end

      puts(table)
    end

    def to_csv 
      CSV.open("#{Dir.pwd}/report.csv", 'w') do |csv|
        #CSV header
        csv << %w{Type View Count AVG(ms) Max Min}
        #CSV content
        stats.each do |path, stat|
          csv << csv_format_row(path, stat)
        end
      end
    end

    private

    def format_row(path, stat, short)
      [
        Utils.type_label(stat.type),
        Utils.path_to_display(path, short: short, length: CONTENT_LENGTH),
        stat.count,
        Utils.avg_label(stat.avg),
        stat.max,
        stat.min,
      ]
    end

    def csv_format_row(path, stat)
      [
        stat.type,
        path,
        stat.count,
        stat.avg,
        stat.max,
        stat.min,
      ]    
    end

    def new_table
      Terminal::Table.new(headings: HEADER, width: DEFAULT_TABLE_WIDTH)
    end

  end
end
