require "spec_helper"

RSpec.describe LogAnalyzer::Stat do
  it "calculates" do
    stat = LogAnalyzer::Stat.new
    stat.push 10
    stat.push 20
    stat.push 30
    expect(stat.count).to eq(3)
    expect(stat.max).to eq(30)
    expect(stat.min).to eq(10)
    expect(stat.avg).to eq(20)
  end
end
