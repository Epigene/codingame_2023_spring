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

        it "returns a decision to mine closest, best minerals" do
          is_expected.to eq("BEACON 4 5000; BEACON 12 5000; MESSAGE Lining up towards 12")
        end
      end

      context "when current ant allocation will-gather and can be spread better" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>14},
            {:i=>2, :resources=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>4, :resources=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>8, :resources=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :resources=>7, :my_ants=>8, :opp_ants=>0},
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

        it "returns a decision to shift part of the focus to mining" do
          is_expected.to eq(
            "BEACON 4 2453; BEACON 2 2453; BEACON 8 2453; BEACON 18 2642; BEACON 12 2000; BEACON 14 2000; " \
            "MESSAGE Finishing egg gathering and expanding to nearby minerals"
          )
        end
      end

      context "when there are a few last minerals on the map" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>30},
            {:i=>4, :resources=>0, :my_ants=>30, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>55, :my_ants=>0, :opp_ants=>30},
            {:i=>12, :resources=>0, :my_ants=>30, :opp_ants=>0},
            {:i=>13, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :resources=>0, :my_ants=>0, :opp_ants=>0},
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

        it "returns a decision to proceed with mining" do
          is_expected.to eq("BEACON 4 5000; BEACON 14 5000; MESSAGE Lining up towards 14")
        end
      end

      context "when we're at the mining stage and could expand on a nearby cell" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>2, :resources=>0, :my_ants=>15, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>4, :resources=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>0, :my_ants=>0, :opp_ants=>14},
            {:i=>8, :resources=>0, :my_ants=>11, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>260, :my_ants=>5, :opp_ants=>0},
            {:i=>13, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>20, :my_ants=>0, :opp_ants=>4},
            {:i=>18, :resources=>0, :my_ants=>10, :opp_ants=>0},
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

        it "returns a decision to beacon the nearby mineral patches also" do
          is_expected.to eq(
            "BEACON 4 5000; BEACON 12 5000; BEACON 14 1000; MESSAGE Expanding on mineral gater"
          )
        end
      end
    end

    context "when seed=-1636922316538223000, bases are very far, init is slow" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>1, :neigh_2=>3, :neigh_3=>-1, :neigh_4=>2, :neigh_5=>4},
          1 => {:i=>1, :type=>1, :resources=>11, :neigh_0=>7, :neigh_1=>9, :neigh_2=>11, :neigh_3=>3, :neigh_4=>0, :neigh_5=>-1},
          2 => {:i=>2, :type=>1, :resources=>11, :neigh_0=>4, :neigh_1=>0, :neigh_2=>-1, :neigh_3=>8, :neigh_4=>10, :neigh_5=>12},
          3 => {:i=>3, :type=>0, :resources=>0, :neigh_0=>1, :neigh_1=>11, :neigh_2=>13, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>0},
          4 => {:i=>4, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>0, :neigh_3=>2, :neigh_4=>12, :neigh_5=>14},
          5 => {:i=>5, :type=>0, :resources=>0, :neigh_0=>15, :neigh_1=>17, :neigh_2=>7, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>24},
          6 => {:i=>6, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>23, :neigh_3=>16, :neigh_4=>18, :neigh_5=>8},
          7 => {:i=>7, :type=>1, :resources=>29, :neigh_0=>17, :neigh_1=>19, :neigh_2=>9, :neigh_3=>1, :neigh_4=>-1, :neigh_5=>5},
          8 => {:i=>8, :type=>1, :resources=>29, :neigh_0=>2, :neigh_1=>-1, :neigh_2=>6, :neigh_3=>18, :neigh_4=>20, :neigh_5=>10},
          9 => {:i=>9, :type=>2, :resources=>85, :neigh_0=>19, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>11, :neigh_4=>1, :neigh_5=>7},
          10 => {:i=>10, :type=>2, :resources=>85, :neigh_0=>12, :neigh_1=>2, :neigh_2=>8, :neigh_3=>20, :neigh_4=>-1, :neigh_5=>-1},
          11 => {:i=>11, :type=>0, :resources=>0, :neigh_0=>9, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>13, :neigh_4=>3, :neigh_5=>1},
          12 => {:i=>12, :type=>0, :resources=>0, :neigh_0=>14, :neigh_1=>4, :neigh_2=>2, :neigh_3=>10, :neigh_4=>-1, :neigh_5=>-1},
          13 => {:i=>13, :type=>1, :resources=>12, :neigh_0=>11, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>21, :neigh_4=>-1, :neigh_5=>3},
          14 => {:i=>14, :type=>1, :resources=>12, :neigh_0=>22, :neigh_1=>-1, :neigh_2=>4, :neigh_3=>12, :neigh_4=>-1, :neigh_5=>-1},
          15 => {:i=>15, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>25, :neigh_2=>17, :neigh_3=>5, :neigh_4=>24, :neigh_5=>30},
          16 => {:i=>16, :type=>0, :resources=>0, :neigh_0=>6, :neigh_1=>23, :neigh_2=>29, :neigh_3=>-1, :neigh_4=>26, :neigh_5=>18},
          17 => {:i=>17, :type=>0, :resources=>0, :neigh_0=>25, :neigh_1=>-1, :neigh_2=>19, :neigh_3=>7, :neigh_4=>5, :neigh_5=>15},
          18 => {:i=>18, :type=>0, :resources=>0, :neigh_0=>8, :neigh_1=>6, :neigh_2=>16, :neigh_3=>26, :neigh_4=>-1, :neigh_5=>20},
          19 => {:i=>19, :type=>1, :resources=>31, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>9, :neigh_4=>7, :neigh_5=>17},
          20 => {:i=>20, :type=>1, :resources=>31, :neigh_0=>10, :neigh_1=>8, :neigh_2=>18, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          21 => {:i=>21, :type=>0, :resources=>0, :neigh_0=>13, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>27, :neigh_4=>23, :neigh_5=>-1},
          22 => {:i=>22, :type=>0, :resources=>0, :neigh_0=>28, :neigh_1=>24, :neigh_2=>-1, :neigh_3=>14, :neigh_4=>-1, :neigh_5=>-1},
          23 => {:i=>23, :type=>2, :resources=>230, :neigh_0=>-1, :neigh_1=>21, :neigh_2=>27, :neigh_3=>29, :neigh_4=>16, :neigh_5=>6},
          24 => {:i=>24, :type=>2, :resources=>230, :neigh_0=>30, :neigh_1=>15, :neigh_2=>5, :neigh_3=>-1, :neigh_4=>22, :neigh_5=>28},
          25 => {:i=>25, :type=>0, :resources=>0, :neigh_0=>33, :neigh_1=>35, :neigh_2=>-1, :neigh_3=>17, :neigh_4=>15, :neigh_5=>-1},
          26 => {:i=>26, :type=>0, :resources=>0, :neigh_0=>18, :neigh_1=>16, :neigh_2=>-1, :neigh_3=>34, :neigh_4=>36, :neigh_5=>-1},
          27 => {:i=>27, :type=>2, :resources=>280, :neigh_0=>21, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>37, :neigh_4=>29, :neigh_5=>23},
          28 => {:i=>28, :type=>2, :resources=>280, :neigh_0=>38, :neigh_1=>30, :neigh_2=>24, :neigh_3=>22, :neigh_4=>-1, :neigh_5=>-1},
          29 => {:i=>29, :type=>0, :resources=>0, :neigh_0=>23, :neigh_1=>27, :neigh_2=>37, :neigh_3=>39, :neigh_4=>-1, :neigh_5=>16},
          30 => {:i=>30, :type=>0, :resources=>0, :neigh_0=>40, :neigh_1=>-1, :neigh_2=>15, :neigh_3=>24, :neigh_4=>28, :neigh_5=>38},
          31 => {:i=>31, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>33, :neigh_3=>-1, :neigh_4=>40, :neigh_5=>-1},
          32 => {:i=>32, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>39, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>34},
          33 => {:i=>33, :type=>2, :resources=>85, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>35, :neigh_3=>25, :neigh_4=>-1, :neigh_5=>31},
          34 => {:i=>34, :type=>2, :resources=>85, :neigh_0=>26, :neigh_1=>-1, :neigh_2=>32, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>36},
          35 => {:i=>35, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>25, :neigh_5=>33},
          36 => {:i=>36, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>26, :neigh_2=>34, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          37 => {:i=>37, :type=>0, :resources=>0, :neigh_0=>27, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>39, :neigh_5=>29},
          38 => {:i=>38, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>40, :neigh_2=>30, :neigh_3=>28, :neigh_4=>-1, :neigh_5=>-1},
          39 => {:i=>39, :type=>0, :resources=>0, :neigh_0=>29, :neigh_1=>37, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>32, :neigh_5=>-1},
          40 => {:i=>40, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>31, :neigh_2=>-1, :neigh_3=>30, :neigh_4=>38, :neigh_5=>-1},
        }
      end

      let(:my_base_indices) { [39] }
      let(:opp_base_indices) { [40] }

      let(:cell_updates) do
        [
          {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>1, :resources=>11, :my_ants=>0, :opp_ants=>0},
          {:i=>2, :resources=>11, :my_ants=>0, :opp_ants=>0},
          {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>4, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>7, :resources=>29, :my_ants=>0, :opp_ants=>0},
          {:i=>8, :resources=>29, :my_ants=>0, :opp_ants=>0},
          {:i=>9, :resources=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>10, :resources=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>11, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>12, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>13, :resources=>12, :my_ants=>0, :opp_ants=>0},
          {:i=>14, :resources=>12, :my_ants=>0, :opp_ants=>0},
          {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>17, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>18, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>19, :resources=>31, :my_ants=>0, :opp_ants=>0},
          {:i=>20, :resources=>31, :my_ants=>0, :opp_ants=>0},
          {:i=>21, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>23, :resources=>230, :my_ants=>0, :opp_ants=>0},
          {:i=>24, :resources=>230, :my_ants=>0, :opp_ants=>0},
          {:i=>25, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>26, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>27, :resources=>280, :my_ants=>0, :opp_ants=>0},
          {:i=>28, :resources=>280, :my_ants=>0, :opp_ants=>0},
          {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>31, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>32, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>33, :resources=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>34, :resources=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>35, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>36, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>37, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>38, :resources=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>39, :resources=>0, :my_ants=>10, :opp_ants=>0},
          {:i=>40, :resources=>0, :my_ants=>0, :opp_ants=>10},
        ]
      end

      it "inits in under a second and provides first command in under 100ms" do
        seconds_to_boot = Benchmark.realtime { decider }
        expect(seconds_to_boot).to be < 1

        ms_to_decide = (Benchmark.realtime { decide_on } * 100).round
        expect(ms_to_decide).to be < 100
      end
    end

    context "when seed=4945114881947644000 and there are eggs next to base" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>1, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>2},
          1 => {:i=>1, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>9, :neigh_2=>11, :neigh_3=>13, :neigh_4=>-1, :neigh_5=>0},
          2 => {:i=>2, :type=>0, :resources=>0, :neigh_0=>14, :neigh_1=>-1, :neigh_2=>0, :neigh_3=>-1, :neigh_4=>10, :neigh_5=>12},
          3 => {:i=>3, :type=>0, :resources=>0, :neigh_0=>15, :neigh_1=>17, :neigh_2=>5, :neigh_3=>-1, :neigh_4=>14, :neigh_5=>22},
          4 => {:i=>4, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>13, :neigh_2=>21, :neigh_3=>16, :neigh_4=>18, :neigh_5=>6},
          5 => {:i=>5, :type=>1, :resources=>17, :neigh_0=>17, :neigh_1=>19, :neigh_2=>7, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>3},
          6 => {:i=>6, :type=>1, :resources=>17, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>4, :neigh_3=>18, :neigh_4=>20, :neigh_5=>8},
          7 => {:i=>7, :type=>0, :resources=>0, :neigh_0=>19, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>9, :neigh_4=>-1, :neigh_5=>5},
          8 => {:i=>8, :type=>0, :resources=>0, :neigh_0=>10, :neigh_1=>-1, :neigh_2=>6, :neigh_3=>20, :neigh_4=>-1, :neigh_5=>-1},
          9 => {:i=>9, :type=>0, :resources=>0, :neigh_0=>7, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>11, :neigh_4=>1, :neigh_5=>-1},
          10 => {:i=>10, :type=>0, :resources=>0, :neigh_0=>12, :neigh_1=>2, :neigh_2=>-1, :neigh_3=>8, :neigh_4=>-1, :neigh_5=>-1},
          11 => {:i=>11, :type=>0, :resources=>0, :neigh_0=>9, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>13, :neigh_5=>1},
          12 => {:i=>12, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>14, :neigh_2=>2, :neigh_3=>10, :neigh_4=>-1, :neigh_5=>-1},
          13 => {:i=>13, :type=>1, :resources=>12, :neigh_0=>1, :neigh_1=>11, :neigh_2=>-1, :neigh_3=>21, :neigh_4=>4, :neigh_5=>-1},
          14 => {:i=>14, :type=>1, :resources=>12, :neigh_0=>22, :neigh_1=>3, :neigh_2=>-1, :neigh_3=>2, :neigh_4=>12, :neigh_5=>-1},
          15 => {:i=>15, :type=>0, :resources=>0, :neigh_0=>23, :neigh_1=>-1, :neigh_2=>17, :neigh_3=>3, :neigh_4=>22, :neigh_5=>30},
          16 => {:i=>16, :type=>0, :resources=>0, :neigh_0=>4, :neigh_1=>21, :neigh_2=>29, :neigh_3=>24, :neigh_4=>-1, :neigh_5=>18},
          17 => {:i=>17, :type=>2, :resources=>90, :neigh_0=>-1, :neigh_1=>25, :neigh_2=>19, :neigh_3=>5, :neigh_4=>3, :neigh_5=>15},
          18 => {:i=>18, :type=>2, :resources=>90, :neigh_0=>6, :neigh_1=>4, :neigh_2=>16, :neigh_3=>-1, :neigh_4=>26, :neigh_5=>20},
          19 => {:i=>19, :type=>0, :resources=>0, :neigh_0=>25, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>7, :neigh_4=>5, :neigh_5=>17},
          20 => {:i=>20, :type=>0, :resources=>0, :neigh_0=>8, :neigh_1=>6, :neigh_2=>18, :neigh_3=>26, :neigh_4=>-1, :neigh_5=>-1},
          21 => {:i=>21, :type=>0, :resources=>0, :neigh_0=>13, :neigh_1=>-1, :neigh_2=>27, :neigh_3=>29, :neigh_4=>16, :neigh_5=>4},
          22 => {:i=>22, :type=>0, :resources=>0, :neigh_0=>30, :neigh_1=>15, :neigh_2=>3, :neigh_3=>14, :neigh_4=>-1, :neigh_5=>28},
          23 => {:i=>23, :type=>2, :resources=>250, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>15, :neigh_4=>30, :neigh_5=>-1},
          24 => {:i=>24, :type=>2, :resources=>250, :neigh_0=>16, :neigh_1=>29, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          25 => {:i=>25, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>19, :neigh_4=>17, :neigh_5=>-1},
          26 => {:i=>26, :type=>0, :resources=>0, :neigh_0=>20, :neigh_1=>18, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          27 => {:i=>27, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>29, :neigh_5=>21},
          28 => {:i=>28, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>30, :neigh_2=>22, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          29 => {:i=>29, :type=>0, :resources=>0, :neigh_0=>21, :neigh_1=>27, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>24, :neigh_5=>16},
          30 => {:i=>30, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>23, :neigh_2=>15, :neigh_3=>22, :neigh_4=>28, :neigh_5=>-1},
        }
      end

      let(:my_base_indices) { [21] }
      let(:opp_base_indices) { [22] }

      describe "#ant_count_cutoff" do
        it "returns starting ants + half of eggs" do
          expect(decider.send(:ant_count_cutoff)).to eq(39)
        end
      end

      context "when it's the first move and we should just 50-50 gather eggs" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :resources=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :resources=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>23, :resources=>250, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>250, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to go for the closest eggs" do
          is_expected.to eq("LINE 21 13 10; MESSAGE Jumping to collect contested eggs on 13")
        end
      end

      context "when it's further along into the game and egg gathering is about to conclude" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>4, :resources=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>5, :resources=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>3, :my_ants=>7, :opp_ants=>0},
            {:i=>7, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>6},
            {:i=>11, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>86, :my_ants=>0, :opp_ants=>2},
            {:i=>18, :resources=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>16, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>23, :resources=>246, :my_ants=>0, :opp_ants=>2},
            {:i=>24, :resources=>250, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to go for the mineral patch next to ants" do
          is_expected.to eq(
            "BEACON 21 3333; BEACON 4 3333; BEACON 6 3333; BEACON 18 2000; MESSAGE Finishing egg gathering and expanding to nearby minerals"
          )
        end
      end
    end

    context "when seed=7220350571314814000 with two eggs next to base" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>0, :resources=>0, :neigh_0=>1, :neigh_1=>3, :neigh_2=>-1, :neigh_3=>2, :neigh_4=>4, :neigh_5=>-1},
          1 => {:i=>1, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>5, :neigh_2=>3, :neigh_3=>0, :neigh_4=>-1, :neigh_5=>14},
          2 => {:i=>2, :type=>0, :resources=>0, :neigh_0=>0, :neigh_1=>-1, :neigh_2=>13, :neigh_3=>-1, :neigh_4=>6, :neigh_5=>4},
          3 => {:i=>3, :type=>0, :resources=>0, :neigh_0=>5, :neigh_1=>7, :neigh_2=>9, :neigh_3=>-1, :neigh_4=>0, :neigh_5=>1},
          4 => {:i=>4, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>0, :neigh_2=>2, :neigh_3=>6, :neigh_4=>8, :neigh_5=>10},
          5 => {:i=>5, :type=>0, :resources=>0, :neigh_0=>17, :neigh_1=>19, :neigh_2=>7, :neigh_3=>3, :neigh_4=>1, :neigh_5=>-1},
          6 => {:i=>6, :type=>0, :resources=>0, :neigh_0=>4, :neigh_1=>2, :neigh_2=>-1, :neigh_3=>18, :neigh_4=>20, :neigh_5=>8},
          7 => {:i=>7, :type=>2, :resources=>245, :neigh_0=>19, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>9, :neigh_4=>3, :neigh_5=>5},
          8 => {:i=>8, :type=>2, :resources=>245, :neigh_0=>10, :neigh_1=>4, :neigh_2=>6, :neigh_3=>20, :neigh_4=>-1, :neigh_5=>-1},
          9 => {:i=>9, :type=>0, :resources=>0, :neigh_0=>7, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>11, :neigh_4=>-1, :neigh_5=>3},
          10 => {:i=>10, :type=>0, :resources=>0, :neigh_0=>12, :neigh_1=>-1, :neigh_2=>4, :neigh_3=>8, :neigh_4=>-1, :neigh_5=>-1},
          11 => {:i=>11, :type=>0, :resources=>0, :neigh_0=>9, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>13, :neigh_5=>-1},
          12 => {:i=>12, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>14, :neigh_2=>-1, :neigh_3=>10, :neigh_4=>-1, :neigh_5=>-1},
          13 => {:i=>13, :type=>1, :resources=>18, :neigh_0=>-1, :neigh_1=>11, :neigh_2=>-1, :neigh_3=>21, :neigh_4=>-1, :neigh_5=>2},
          14 => {:i=>14, :type=>1, :resources=>18, :neigh_0=>22, :neigh_1=>-1, :neigh_2=>1, :neigh_3=>-1, :neigh_4=>12, :neigh_5=>-1},
          15 => {:i=>15, :type=>1, :resources=>19, :neigh_0=>23, :neigh_1=>25, :neigh_2=>17, :neigh_3=>-1, :neigh_4=>22, :neigh_5=>32},
          16 => {:i=>16, :type=>1, :resources=>19, :neigh_0=>-1, :neigh_1=>21, :neigh_2=>31, :neigh_3=>24, :neigh_4=>26, :neigh_5=>18},
          17 => {:i=>17, :type=>0, :resources=>0, :neigh_0=>25, :neigh_1=>27, :neigh_2=>19, :neigh_3=>5, :neigh_4=>-1, :neigh_5=>15},
          18 => {:i=>18, :type=>0, :resources=>0, :neigh_0=>6, :neigh_1=>-1, :neigh_2=>16, :neigh_3=>26, :neigh_4=>28, :neigh_5=>20},
          19 => {:i=>19, :type=>1, :resources=>17, :neigh_0=>27, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>7, :neigh_4=>5, :neigh_5=>17},
          20 => {:i=>20, :type=>1, :resources=>17, :neigh_0=>8, :neigh_1=>6, :neigh_2=>18, :neigh_3=>28, :neigh_4=>-1, :neigh_5=>-1},
          21 => {:i=>21, :type=>0, :resources=>0, :neigh_0=>13, :neigh_1=>-1, :neigh_2=>29, :neigh_3=>31, :neigh_4=>16, :neigh_5=>-1},
          22 => {:i=>22, :type=>0, :resources=>0, :neigh_0=>32, :neigh_1=>15, :neigh_2=>-1, :neigh_3=>14, :neigh_4=>-1, :neigh_5=>30},
          23 => {:i=>23, :type=>2, :resources=>260, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>25, :neigh_3=>15, :neigh_4=>32, :neigh_5=>-1},
          24 => {:i=>24, :type=>2, :resources=>260, :neigh_0=>16, :neigh_1=>31, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>26},
          25 => {:i=>25, :type=>1, :resources=>27, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>27, :neigh_3=>17, :neigh_4=>15, :neigh_5=>23},
          26 => {:i=>26, :type=>1, :resources=>27, :neigh_0=>18, :neigh_1=>16, :neigh_2=>24, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>28},
          27 => {:i=>27, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>19, :neigh_4=>17, :neigh_5=>25},
          28 => {:i=>28, :type=>0, :resources=>0, :neigh_0=>20, :neigh_1=>18, :neigh_2=>26, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          29 => {:i=>29, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>31, :neigh_5=>21},
          30 => {:i=>30, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>32, :neigh_2=>22, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          31 => {:i=>31, :type=>0, :resources=>0, :neigh_0=>21, :neigh_1=>29, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>24, :neigh_5=>16},
          32 => {:i=>32, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>23, :neigh_2=>15, :neigh_3=>22, :neigh_4=>30, :neigh_5=>-1},
        }
      end

      let(:my_base_indices) { [18] }
      let(:opp_base_indices) { [17] }

      context "when there's a cluster of eggs next to base" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>19, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>19, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>18, :resources=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>19, :resources=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :resources=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>27, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :resources=>27, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to efficiently gather those" do
          is_expected.to eq("LINE 18 16 1; LINE 18 20 1; LINE 18 26 1; MESSAGE Eggs next to base, yay")
        end
      end

      context "when eggs next to base are mining out" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>5},
            {:i=>16, :resources=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>17, :resources=>0, :my_ants=>0, :opp_ants=>16},
            {:i=>18, :resources=>0, :my_ants=>34, :opp_ants=>0},
            {:i=>19, :resources=>7, :my_ants=>0, :opp_ants=>14},
            {:i=>20, :resources=>0, :my_ants=>12, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :resources=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>22, :my_ants=>0, :opp_ants=>9},
            {:i=>26, :resources=>2, :my_ants=>12, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to expand to nearby crystals while grapsing for contested eggs" do
          is_expected.to eq("BEACON 26 9; LINE 18 13 10; LINE 18 8 10; LINE 18 24 10; MESSAGE opportune crossfading eggs to further egg gather")
        end
      end

      context "when we've opportunistically expanded to minerals, but the main focus should remain eggs" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>7, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>236, :my_ants=>9, :opp_ants=>0},
            {:i=>9, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>16, :opp_ants=>0},
            {:i=>17, :resources=>0, :my_ants=>0, :opp_ants=>35},
            {:i=>18, :resources=>0, :my_ants=>12, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>11},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :resources=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>252, :my_ants=>8, :opp_ants=>0},
            {:i=>25, :resources=>8, :my_ants=>0, :opp_ants=>19},
            {:i=>26, :resources=>0, :my_ants=>9, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :resources=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to line to eggs AND preserve a minimal effort at minerals also" do
          is_expected.to eq("LINE 18 13 10; LINE 18 24 5; LINE 18 8 5; MESSAGE Jumping to collect contested eggs on 13")
        end
      end
    end

    context "when seed= with bases far apart and there being atari" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>2, :resources=>48, :neigh_0=>1, :neigh_1=>3, :neigh_2=>-1, :neigh_3=>2, :neigh_4=>4, :neigh_5=>-1},
          1 => {:i=>1, :type=>0, :resources=>0, :neigh_0=>5, :neigh_1=>-1, :neigh_2=>3, :neigh_3=>0, :neigh_4=>-1, :neigh_5=>14},
          2 => {:i=>2, :type=>0, :resources=>0, :neigh_0=>0, :neigh_1=>-1, :neigh_2=>13, :neigh_3=>6, :neigh_4=>-1, :neigh_5=>4},
          3 => {:i=>3, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>7, :neigh_2=>9, :neigh_3=>-1, :neigh_4=>0, :neigh_5=>1},
          4 => {:i=>4, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>0, :neigh_2=>2, :neigh_3=>-1, :neigh_4=>8, :neigh_5=>10},
          5 => {:i=>5, :type=>0, :resources=>0, :neigh_0=>15, :neigh_1=>17, :neigh_2=>-1, :neigh_3=>1, :neigh_4=>14, :neigh_5=>24},
          6 => {:i=>6, :type=>0, :resources=>0, :neigh_0=>2, :neigh_1=>13, :neigh_2=>23, :neigh_3=>16, :neigh_4=>18, :neigh_5=>-1},
          7 => {:i=>7, :type=>2, :resources=>280, :neigh_0=>19, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>9, :neigh_4=>3, :neigh_5=>-1},
          8 => {:i=>8, :type=>2, :resources=>280, :neigh_0=>10, :neigh_1=>4, :neigh_2=>-1, :neigh_3=>20, :neigh_4=>-1, :neigh_5=>-1},
          9 => {:i=>9, :type=>1, :resources=>10, :neigh_0=>7, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>11, :neigh_4=>-1, :neigh_5=>3},
          10 => {:i=>10, :type=>1, :resources=>10, :neigh_0=>12, :neigh_1=>-1, :neigh_2=>4, :neigh_3=>8, :neigh_4=>-1, :neigh_5=>-1},
          11 => {:i=>11, :type=>2, :resources=>210, :neigh_0=>9, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>21, :neigh_4=>13, :neigh_5=>-1},
          12 => {:i=>12, :type=>2, :resources=>210, :neigh_0=>22, :neigh_1=>14, :neigh_2=>-1, :neigh_3=>10, :neigh_4=>-1, :neigh_5=>-1},
          13 => {:i=>13, :type=>1, :resources=>12, :neigh_0=>-1, :neigh_1=>11, :neigh_2=>21, :neigh_3=>23, :neigh_4=>6, :neigh_5=>2},
          14 => {:i=>14, :type=>1, :resources=>12, :neigh_0=>24, :neigh_1=>5, :neigh_2=>1, :neigh_3=>-1, :neigh_4=>12, :neigh_5=>22},
          15 => {:i=>15, :type=>0, :resources=>0, :neigh_0=>25, :neigh_1=>27, :neigh_2=>17, :neigh_3=>5, :neigh_4=>24, :neigh_5=>-1},
          16 => {:i=>16, :type=>0, :resources=>0, :neigh_0=>6, :neigh_1=>23, :neigh_2=>-1, :neigh_3=>26, :neigh_4=>28, :neigh_5=>18},
          17 => {:i=>17, :type=>2, :resources=>90, :neigh_0=>27, :neigh_1=>29, :neigh_2=>19, :neigh_3=>-1, :neigh_4=>5, :neigh_5=>15},
          18 => {:i=>18, :type=>2, :resources=>90, :neigh_0=>-1, :neigh_1=>6, :neigh_2=>16, :neigh_3=>28, :neigh_4=>30, :neigh_5=>20},
          19 => {:i=>19, :type=>0, :resources=>0, :neigh_0=>29, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>7, :neigh_4=>-1, :neigh_5=>17},
          20 => {:i=>20, :type=>0, :resources=>0, :neigh_0=>8, :neigh_1=>-1, :neigh_2=>18, :neigh_3=>30, :neigh_4=>-1, :neigh_5=>-1},
          21 => {:i=>21, :type=>1, :resources=>39, :neigh_0=>11, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>31, :neigh_4=>23, :neigh_5=>13},
          22 => {:i=>22, :type=>1, :resources=>39, :neigh_0=>32, :neigh_1=>24, :neigh_2=>14, :neigh_3=>12, :neigh_4=>-1, :neigh_5=>-1},
          23 => {:i=>23, :type=>0, :resources=>0, :neigh_0=>13, :neigh_1=>21, :neigh_2=>31, :neigh_3=>-1, :neigh_4=>16, :neigh_5=>6},
          24 => {:i=>24, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>15, :neigh_2=>5, :neigh_3=>14, :neigh_4=>22, :neigh_5=>32},
          25 => {:i=>25, :type=>2, :resources=>245, :neigh_0=>33, :neigh_1=>35, :neigh_2=>27, :neigh_3=>15, :neigh_4=>-1, :neigh_5=>42},
          26 => {:i=>26, :type=>2, :resources=>245, :neigh_0=>16, :neigh_1=>-1, :neigh_2=>41, :neigh_3=>34, :neigh_4=>36, :neigh_5=>28},
          27 => {:i=>27, :type=>0, :resources=>0, :neigh_0=>35, :neigh_1=>37, :neigh_2=>29, :neigh_3=>17, :neigh_4=>15, :neigh_5=>25},
          28 => {:i=>28, :type=>0, :resources=>0, :neigh_0=>18, :neigh_1=>16, :neigh_2=>26, :neigh_3=>36, :neigh_4=>38, :neigh_5=>30},
          29 => {:i=>29, :type=>0, :resources=>0, :neigh_0=>37, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>19, :neigh_4=>17, :neigh_5=>27},
          30 => {:i=>30, :type=>0, :resources=>0, :neigh_0=>20, :neigh_1=>18, :neigh_2=>28, :neigh_3=>38, :neigh_4=>-1, :neigh_5=>-1},
          31 => {:i=>31, :type=>0, :resources=>0, :neigh_0=>21, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>39, :neigh_4=>-1, :neigh_5=>23},
          32 => {:i=>32, :type=>0, :resources=>0, :neigh_0=>40, :neigh_1=>-1, :neigh_2=>24, :neigh_3=>22, :neigh_4=>-1, :neigh_5=>-1},
          33 => {:i=>33, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>35, :neigh_3=>25, :neigh_4=>42, :neigh_5=>-1},
          34 => {:i=>34, :type=>0, :resources=>0, :neigh_0=>26, :neigh_1=>41, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>36},
          35 => {:i=>35, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>37, :neigh_3=>27, :neigh_4=>25, :neigh_5=>33},
          36 => {:i=>36, :type=>0, :resources=>0, :neigh_0=>28, :neigh_1=>26, :neigh_2=>34, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>38},
          37 => {:i=>37, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>29, :neigh_4=>27, :neigh_5=>35},
          38 => {:i=>38, :type=>0, :resources=>0, :neigh_0=>30, :neigh_1=>28, :neigh_2=>36, :neigh_3=>-1, :neigh_4=>-1, :neigh_5=>-1},
          39 => {:i=>39, :type=>0, :resources=>0, :neigh_0=>31, :neigh_1=>-1, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>41, :neigh_5=>-1},
          40 => {:i=>40, :type=>0, :resources=>0, :neigh_0=>-1, :neigh_1=>42, :neigh_2=>-1, :neigh_3=>32, :neigh_4=>-1, :neigh_5=>-1},
          41 => {:i=>41, :type=>1, :resources=>10, :neigh_0=>-1, :neigh_1=>39, :neigh_2=>-1, :neigh_3=>-1, :neigh_4=>34, :neigh_5=>26},
          42 => {:i=>42, :type=>1, :resources=>10, :neigh_0=>-1, :neigh_1=>33, :neigh_2=>25, :neigh_3=>-1, :neigh_4=>40, :neigh_5=>-1},
        }
      end

      let(:my_base_indices) { [40] }
      let(:opp_base_indices) { [39] }

      context "when it's the first move and there are egss next to base" do
        let(:cell_updates) do
          [
            {:i=>0, :resources=>48, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :resources=>280, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :resources=>280, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :resources=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :resources=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :resources=>210, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :resources=>210, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :resources=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :resources=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :resources=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :resources=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :resources=>39, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :resources=>39, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :resources=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>33, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>34, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>35, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>36, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>37, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>38, :resources=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>39, :resources=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>40, :resources=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>41, :resources=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>42, :resources=>10, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns command to just go for the eggs " do
          is_expected.to eq("LINE 40 42 1; MESSAGE Egg next to base, yay")
        end
      end
    end
  end
end
