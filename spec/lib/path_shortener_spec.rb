require "spec_helper"

RSpec.describe LogAnalyzer::PathShortener do
  describe "#shrink" do
    subject { described_class.shrink(path) }

    context "when path lenght is less than max" do
      let(:path) { "/home/user/.rbenv/versions/file.rb" }

      it { is_expected.to eq path }
    end

    context "when path lenght is more than max" do
      let(:path) { "/home/developer/.rbenv/versions/2.2.5/lib/ruby/gems/2.2.0/gems/actionpack-4.2.8/lib/action_dispatch/middleware/templates/routes/_table.html.erb" }
      let(:short_path) { "/h/d/.r/v/2/l/r/g/2/g/a/l/a/m/t/r/_table.html.erb" }

      it { is_expected.to eq short_path }
    end
  end
end
