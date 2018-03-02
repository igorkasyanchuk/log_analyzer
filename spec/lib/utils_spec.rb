require "spec_helper"

RSpec.describe LogAnalyzer::Utils do
  it "filename" do
    expect { LogAnalyzer::Utils.report_name('csv') }.not_to raise_error
  end
end
