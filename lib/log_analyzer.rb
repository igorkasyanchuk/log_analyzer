require "log_analyzer/version"
require "log_analyzer/stat"
require "log_analyzer/analyzer"

module LogAnalyzer
  def self.analyze(filename:)
    LogAnalyzer::Analyzer.new(filename: filename)
  end
end
