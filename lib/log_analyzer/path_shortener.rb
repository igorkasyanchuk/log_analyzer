module LogAnalyzer
  class PathShortener
    CHARS_TO_IGNORE = %w(.)
    MAX_LENGTH = 80

    def initialize(path, max: MAX_LENGTH)
      @path = path
      @max  = max
    end

    def self.shrink(path, max: MAX_LENGTH)
      new(path, max: max).shrink
    end

    def shrink
      return path if path.length < max

      File.join(
        File.dirname(path).split(File::SEPARATOR).map { |dir| short_name(dir) },
        File.basename(path)
      )
    end

    private

    attr_reader :path, :max

    def short_name(name)
      first_char = name[0] || "" # avoid nils in directory names

      CHARS_TO_IGNORE.include?(first_char) ? name[0..1] : first_char
    end
  end
end
