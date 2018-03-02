require "spec_helper"

RSpec.describe LogAnalyzer do
  it "has a version number" do
    expect(LogAnalyzer::VERSION).not_to be nil
  end

  it 'has working shortcut' do
    expect { LogAnalyzer.analyze(filename: TEST_FILE).run }.not_to raise_error
  end

  it 'handle ok when file not found' do
    expect { LogAnalyzer.analyze(filename: 'xyz').run }.to raise_error(SystemExit)
  end

end
