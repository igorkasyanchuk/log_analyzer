require "terminal-table"
require "colorize"
require "log_analyzer/version"
require "log_analyzer/configuration"
require "log_analyzer/stat"
require "log_analyzer/analyzer"

module LogAnalyzer
  def self.analyze(filename:)
    LogAnalyzer::Analyzer.new(filename: filename)
  end
end
