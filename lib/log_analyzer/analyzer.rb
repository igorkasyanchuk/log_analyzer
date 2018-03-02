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

        table.add_row console_row(path, stat, short)

        rows_count += 1
      end

      # adding a footer
      if rows_count > ROWS_FOR_FOOTER
        table.add_separator
        table.add_row(HEADER)
      end

      puts(table)
    end

    def to_pdf(out_filename, short: false)
      this = self
      data = [HEADER]
      this.stats.each do |path, stat|
        next unless LogAnalyzer.configuration.filters.include?(stat.type)
        data << pdf_row(path, stat, short)
      end
      Prawn::Document.generate(out_filename) do
        width     = 72
        text "LogAnalyzer Report", align: :center, size: 18
        text Time.now.strftime("Generated on %B %d, %Y at %I:%M%p") , align: :center, size: 7
        move_down 12
        table data,
          width: bounds.width,
          header: true,
          row_colors: ["FFFFFF", "FFFFCC"],
          cell_style: { padding: [2, 2, 2, 2], size: 7 } do |t|
            t.columns(0).style(align: :center)
        end
        move_down 20
        text %(Generated by <link href="https://github.com/igorkasyanchuk/log_analyzer">https://github.com/igorkasyanchuk/log_analyzer</link>.), inline_format: true, size: 5
      end
    end

    def to_csv(out_filename, short: false)
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

    def console_row(path, stat, short)
      [
        Utils.type_label(stat.type),
        Utils.path_to_display(path, short: short, length: CONTENT_LENGTH),
        stat.count,
        Utils.avg_label(stat.avg),
        stat.max,
        stat.min,
      ]
    end

    def simple_row(path, stat, short)
      [
        stat.type,
        Utils.path_to_display(path, short: short, length: CONTENT_LENGTH),
        stat.count,
        stat.avg,
        stat.max,
        stat.min,
      ]
    end

    alias :simple_row :pdf_row
    alias :simple_row :csv_format_row

    def new_table
      Terminal::Table.new(headings: HEADER, width: DEFAULT_TABLE_WIDTH)
    end

  end
end
