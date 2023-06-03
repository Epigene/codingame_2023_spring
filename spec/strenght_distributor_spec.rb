# frozen_string_literal: true

RSpec.describe StrengthDistributor, instance_name: :distributor do
  let(:distributor) { described_class.new(from: from, to: to, ants: ants, graph: graph) }

  let(:from) { 1 }
  let(:to) { 4 }
  let(:graph) { Graph.new }

  before do
    allow(distributor).to receive(:path) { path }
  end

  describe "#call" do
    subject(:call) { distributor.call }

    context "when I have 10 ants and goal is 3 cells away" do
      let(:ants) { 10 }
      let(:path) { [1, 2, 3, 4] }

      it "assumes destination has high 'heat' and frontloads ants there" do
        is_expected.to eq("BEACON 1 2000; BEACON 2 2000; BEACON 3 2000; BEACON 4 4000")
      end
    end

    context "when I have 12 ants spread out across 4 cells already" do
      let(:ants) { 12 }
      let(:path) { [1, 2, 3, 4] }

      it "spreads butter evenly" do
        is_expected.to eq("BEACON 1 2500; BEACON 2 2500; BEACON 3 2500; BEACON 4 2500")
      end
    end

    context "when I have 13 ants spread out across 4 cells already" do
      let(:ants) { 13 }
      let(:path) { [1, 2, 3, 4] }

      it "spreads evenly while frontloading remainder" do
        is_expected.to eq("BEACON 1 2308; BEACON 2 2308; BEACON 3 2308; BEACON 4 3077")
      end
    end

    # 7 + 6 + 5 + 3
    context "when I have 21 ants spread out across 4 cells already, the numbers are getting higher" do
      let(:ants) { 21 }
      let(:path) { [1, 2, 3, 4] }

      it "spreads evenly while frontloading remainder" do
        is_expected.to eq("BEACON 1 2381; BEACON 2 2381; BEACON 3 2381; BEACON 4 2857")
      end
    end
  end
end
