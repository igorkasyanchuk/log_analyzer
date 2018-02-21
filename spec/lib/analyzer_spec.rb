require "spec_helper"

RSpec.describe LogAnalyzer::Analyzer do
  let!(:analyzer) { LogAnalyzer::Analyzer.new(filename: TEST_FILE) }

  it "runs" do
    expect { analyzer.run }.not_to raise_error
  end

  it "sorts" do
    analyzer.run
    expect { analyzer.order(by: :time) }.not_to raise_error
    expect { analyzer.order(by: :name) }.not_to raise_error
    expect { analyzer.order(by: :count) }.not_to raise_error
  end

  it "visualizes" do
    analyzer.run
    expect { analyzer.visualize }.not_to raise_error
  end

  ['ALL', 'Partials', 'Views'].each do |filter|
    it "visualizes according to filter=#{filter}" do
      LogAnalyzer::Configuration.reset
      LogAnalyzer::Configuration.configure do |config|
        config.filter = filter
      end
      analyzer.run
      expect { analyzer.visualize }.not_to raise_error
    end
  end

end
