require "terminal-table"
require "colorize"
require "log_analyzer/version"
require "log_analyzer/configuration"
require "log_analyzer/utils"
require "log_analyzer/stat"
require "log_analyzer/analyzer"
require "log_analyzer/path_shortener"

module LogAnalyzer
  def LogAnalyzer.analyze(filename:)
    LogAnalyzer::Analyzer.new(filename: filename)
  end

  def LogAnalyzer.configuration
    LogAnalyzer::Configuration.configuration
  end
end
