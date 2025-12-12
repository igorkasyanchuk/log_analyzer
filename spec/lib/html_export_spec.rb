require "spec_helper"

RSpec.describe "HTML Export" do
  before do
    FileUtils.rm("#{Dir.pwd}/file.html") rescue nil
    LogAnalyzer::Configuration.configure do |config|
      config.filter = "all"
    end
  end

  let!(:analyzer) { LogAnalyzer::Analyzer.new(filename: TEST_FILE) }

  it "exports log to html" do
    analyzer.run
    expect { analyzer.to_html('file.html') }.not_to raise_error
    expect(File.exist?('file.html')).to be true
  end

  it "exports log to html with short paths" do
    analyzer.run
    expect { analyzer.to_html('file.html', short: true) }.not_to raise_error
    expect(File.exist?('file.html')).to be true
  end

  it "generates valid HTML structure" do
    analyzer.run
    analyzer.to_html('file.html')
    content = File.read('file.html')
    
    # Check for essential HTML elements
    expect(content).to include('<!DOCTYPE html>')
    expect(content).to include('<html lang="en">')
    expect(content).to include('LogAnalyzer Report')
    expect(content).to include('datatables')
    expect(content).to include('<table id="logTable"')
    expect(content).to include('<thead>')
    expect(content).to include('<tbody>')
  end

  it "includes DataTables.js libraries" do
    analyzer.run
    analyzer.to_html('file.html')
    content = File.read('file.html')
    
    expect(content).to include('jquery')
    expect(content).to include('dataTables')
    expect(content).to include('cdn.datatables.net')
  end

  it "includes proper table headers" do
    analyzer.run
    analyzer.to_html('file.html')
    content = File.read('file.html')
    
    expect(content).to include('<th>Type</th>')
    expect(content).to include('<th>View</th>')
    expect(content).to include('<th>Count</th>')
    expect(content).to include('<th>AVG (ms)</th>')
    expect(content).to include('<th>Max</th>')
    expect(content).to include('<th>Min</th>')
  end

  it "applies color-coded styling for performance metrics" do
    analyzer.run
    analyzer.to_html('file.html')
    content = File.read('file.html')
    
    expect(content).to include('.avg-danger')
    expect(content).to include('.avg-warning')
    expect(content).to include('.avg-info')
    expect(content).to include('.avg-success')
  end

  it "includes type badges for partials and views" do
    analyzer.run
    analyzer.to_html('file.html')
    content = File.read('file.html')
    
    expect(content).to include('.type-P')
    expect(content).to include('.type-V')
    expect(content).to include('type-badge')
  end

  it "escapes HTML in view paths" do
    analyzer.run
    analyzer.to_html('file.html')
    content = File.read('file.html')
    
    # If there are any < > & characters in paths, they should be escaped
    expect(content).not_to match(/<td>[^<]*<[^t\/][^>]*>/m) # no unescaped tags in td cells
  end

  after do
    FileUtils.rm("#{Dir.pwd}/file.html") rescue nil
  end
end
