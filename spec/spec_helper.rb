require "bundler/setup"

require 'simplecov'
require 'pry'

RSPEC_ROOT  = File.dirname(__FILE__)
TEST_FILE   = "#{RSPEC_ROOT}/files/file.log"
TEST_FILE_7 = "#{RSPEC_ROOT}/files/file7.log"

require "log_analyzer"

puts "Using: #{LogAnalyzer::Analyzer::MATCHER}"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
