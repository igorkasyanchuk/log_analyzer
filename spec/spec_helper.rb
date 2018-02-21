require "bundler/setup"

require 'simplecov'

SimpleCov.start

RSPEC_ROOT = File.dirname(__FILE__)
TEST_FILE  = "#{RSPEC_ROOT}/files/file.log"

require "log_analyzer"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

