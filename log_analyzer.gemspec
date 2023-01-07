# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_analyzer/version'

Gem::Specification.new do |spec|
  spec.name          = "log_analyzer"
  spec.version       = LogAnalyzer::VERSION
  spec.authors       = ["Igor Kasyanchuk"]
  spec.email         = ["igorkasyanchuk@gmail.com"]

  spec.summary       = %q{log_analyzer gem is created to get statistics about your views rendering performance.}
  spec.description   = %q{log_analyzer gem is created to get statistics about your views rendering performance.}
  spec.homepage      = "https://github.com/igorkasyanchuk"
  spec.license       = "MIT"

  spec.files         = Dir["{lib,test}/**/*", "log_analyzer.gemspec", "Gemfile", "Gemfile.lock", "MIT-LICENSE", "Rakefile", "README.md", "bin/log_analyzer"]
  spec.test_files    = Dir["rspec/**/*"]

  spec.executables   = ['log_analyzer']

  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "rake"
  spec.add_dependency "terminal-table"
  spec.add_dependency "colorize"
  spec.add_dependency "prawn"
  spec.add_dependency "prawn-table"
  spec.add_dependency "spreadsheet"

  spec.add_development_dependency "bundler", "> 1.14"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"
end
