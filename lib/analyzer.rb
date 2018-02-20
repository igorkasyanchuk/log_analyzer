class Array
  def sum
    inject( nil ) { |sum,x| sum ? sum+x : x }
  end

  def mean
    sum.to_f / size.to_f
  end
end

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
    @avg ||= data.mean.round(2)
  end

  def max; @data.max; end
  def min; @data.min; end
end

class Analyzer
  TABLE_WIDTH = 120

  attr_reader :filename
  attr_reader :stats

  def initialize(filename:)
    @filename = filename
    @stats    = {}
  end

  def run
    IO.foreach(filename).lazy.each do |line|
      if line =~ /Rendered (.*) \((.*)ms\)/
        @stats[$1] ||= Stat.new
        @stats[$1].push($2.to_f)
      end
    end
  end

  def sort_by(order = :time)
    case order
    when :time
      @stats = @stats.sort{|a, b| a[1].avg <=> b[1].avg }
    when :count
      @stats = @stats.sort{|a, b| a[1].count <=> b[1].count }
    end
  end

  def visualize(limit: 100)
    table = Terminal::Table.new :headings => ['Path', 'Count', 'AVG (ms)', 'Max', 'Min'], width: TABLE_WIDTH do |t|
      stats.each do |path, stat|
        t.add_row [
          path[0..TABLE_WIDTH - 20],
          stat.count,
          avg_label(stat.avg),
          stat.max,
          stat.min,
        ]
      end
    end
    puts table
  end

  def avg_label(avg)
    str = avg.to_s
    if avg > 800
      str.white.on_red
    elsif avg > 400
      str.red
    elsif avg > 100
      str.yellow
    else
      str.green
    end
  end

end