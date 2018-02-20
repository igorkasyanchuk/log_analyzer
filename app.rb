require 'bundler'
require 'pry'
require 'terminal-table'
require 'colorize'
require_relative 'lib/analyzer.rb'

analyzer = Analyzer.new(filename: 'production.log')
analyzer.run
analyzer.sort_by :time
analyzer.visualize