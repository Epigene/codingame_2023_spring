# frozen_string_literal: true

RSpec.describe Decider, instance_name: :decider do
  let(:decider) do
    described_class.new(cells:, number_of_bases: 1, my_base_indices:, opp_base_indices:)
  end

  describe "#decide_on(cell_updates:)" do
    subject(:decide_on) { decider.decide_on(cell_updates: cell_updates) }

    context "when seed=4315077650250445000, bases are close, nothing is contested, just go for eggs" do
      let(:cells) do
        {
          0 => {i: 0, type: 0, resources: 0, neigh_0: -1, neigh_1: 1, neigh_2: 3, neigh_3: -1, neigh_4: 2,
                neigh_5: 4},
          1 => {i: 1, type: 0, resources: 0, neigh_0: 7, neigh_1: 9, neigh_2: 11, neigh_3: 3, neigh_4: 0,
                neigh_5: -1},
          2 => {i: 2, type: 0, resources: 0, neigh_0: 4, neigh_1: 0, neigh_2: -1, neigh_3: 8, neigh_4: 10,
                neigh_5: 12},
          3 => {i: 3, type: 0, resources: 0, neigh_0: 1, neigh_1: 11, neigh_2: 13, neigh_3: 15, neigh_4: -1,
                neigh_5: 0},
          4 => {i: 4, type: 0, resources: 0, neigh_0: 16, neigh_1: -1, neigh_2: 0, neigh_3: 2, neigh_4: 12,
                neigh_5: 14},
          5 => {i: 5, type: 0, resources: 0, neigh_0: -1, neigh_1: 17, neigh_2: 7, neigh_3: -1, neigh_4: 16,
                neigh_5: 22},
          6 => {i: 6, type: 0, resources: 0, neigh_0: -1, neigh_1: 15, neigh_2: 21, neigh_3: -1, neigh_4: 18,
                neigh_5: 8},
          7 => {i: 7, type: 1, resources: 26, neigh_0: 17, neigh_1: 19, neigh_2: 9, neigh_3: 1, neigh_4: -1,
                neigh_5: 5},
          8 => {i: 8, type: 1, resources: 26, neigh_0: 2, neigh_1: -1, neigh_2: 6, neigh_3: 18, neigh_4: 20,
                neigh_5: 10},
          9 => {i: 9, type: 0, resources: 0, neigh_0: 19, neigh_1: -1, neigh_2: -1, neigh_3: 11, neigh_4: 1,
                neigh_5: 7},
          10 => {i: 10, type: 0, resources: 0, neigh_0: 12, neigh_1: 2, neigh_2: 8, neigh_3: 20, neigh_4: -1,
                 neigh_5: -1},
          11 => {i: 11, type: 2, resources: 265, neigh_0: 9, neigh_1: -1, neigh_2: -1, neigh_3: 13, neigh_4: 3,
                 neigh_5: 1},
          12 => {i: 12, type: 2, resources: 265, neigh_0: 14, neigh_1: 4, neigh_2: 2, neigh_3: 10, neigh_4: -1,
                 neigh_5: -1},
          13 => {i: 13, type: 2, resources: 65, neigh_0: 11, neigh_1: -1, neigh_2: -1, neigh_3: -1, neigh_4: 15,
                 neigh_5: 3},
          14 => {i: 14, type: 2, resources: 65, neigh_0: -1, neigh_1: 16, neigh_2: 4, neigh_3: 12, neigh_4: -1,
                 neigh_5: -1},
          15 => {i: 15, type: 0, resources: 0, neigh_0: 3, neigh_1: 13, neigh_2: -1, neigh_3: 21, neigh_4: 6,
                 neigh_5: -1},
          16 => {i: 16, type: 0, resources: 0, neigh_0: 22, neigh_1: 5, neigh_2: -1, neigh_3: 4, neigh_4: 14,
                 neigh_5: -1},
          17 => {i: 17, type: 1, resources: 24, neigh_0: 25, neigh_1: 27, neigh_2: 19, neigh_3: 7, neigh_4: 5,
                 neigh_5: -1},
          18 => {i: 18, type: 1, resources: 24, neigh_0: 8, neigh_1: 6, neigh_2: -1, neigh_3: 26, neigh_4: 28,
                 neigh_5: 20},
          19 => {i: 19, type: 0, resources: 0, neigh_0: 27, neigh_1: -1, neigh_2: -1, neigh_3: 9, neigh_4: 7,
                 neigh_5: 17},
          20 => {i: 20, type: 0, resources: 0, neigh_0: 10, neigh_1: 8, neigh_2: 18, neigh_3: 28, neigh_4: -1,
                 neigh_5: -1},
          27 => {i: 27, type: 0, resources: 0, neigh_0: -1, neigh_1: -1, neigh_2: -1, neigh_3: 19, neigh_4: 17,
                 neigh_5: 25},
          28 => {i: 28, type: 0, resources: 0, neigh_0: 20, neigh_1: 18, neigh_2: 26, neigh_3: -1, neigh_4: -1,
                 neigh_5: -1}
        }
      end

      let(:my_base_indices) { [4] }
      let(:opp_base_indices) { [3] }

      context "when nothing is contested and the logical move is to gather eggs" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>4, :resources=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>26, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>26, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :resources=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0}
          ]
        end

        it "returns a decision to go for the closest eggs" do
          is_expected.to eq("BEACON 4 3000; BEACON 2 3000; BEACON 8 4000; MESSAGE close eggs on 8")
        end
      end

      context "when there's an opportunity to expand to neighboring cells" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>3},
            {:i=>2, :resources=>0, :my_ants=>3, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>7},
            {:i=>4, :resources=>0, :my_ants=>6, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>23, :my_ants=>0, :opp_ants=>3},
            {:i=>8, :resources=>23, :my_ants=>4, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :resources=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to expand" do
          is_expected.to eq("BEACON 4 3077; BEACON 2 3077; BEACON 8 3846; BEACON 18 3077; MESSAGE Expanding on egg gathering")
        end
      end

      context "when I've just gathered my half of eggs and should just go for mineral win" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>2, :resources=>0, :my_ants=>18, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>4, :resources=>0, :my_ants=>20, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>0, :my_ants=>0, :opp_ants=>14},
            {:i=>8, :resources=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>20, :my_ants=>0, :opp_ants=>4},
            {:i=>18, :resources=>0, :my_ants=>9, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to " do
          is_expected.to eq("BEACON 4 5000; BEACON 12 5000; MESSAGE Lining up towards 12")
        end
      end
    end
  end
end
