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
          0 => {i: 0, type: 0, res: 0, ne_0: -1, ne_1: 1, ne_2: 3, ne_3: -1, ne_4: 2,
                ne_5: 4},
          1 => {i: 1, type: 0, res: 0, ne_0: 7, ne_1: 9, ne_2: 11, ne_3: 3, ne_4: 0,
                ne_5: -1},
          2 => {i: 2, type: 0, res: 0, ne_0: 4, ne_1: 0, ne_2: -1, ne_3: 8, ne_4: 10,
                ne_5: 12},
          3 => {i: 3, type: 0, res: 0, ne_0: 1, ne_1: 11, ne_2: 13, ne_3: 15, ne_4: -1,
                ne_5: 0},
          4 => {i: 4, type: 0, res: 0, ne_0: 16, ne_1: -1, ne_2: 0, ne_3: 2, ne_4: 12,
                ne_5: 14},
          5 => {i: 5, type: 0, res: 0, ne_0: -1, ne_1: 17, ne_2: 7, ne_3: -1, ne_4: 16,
                ne_5: 22},
          6 => {i: 6, type: 0, res: 0, ne_0: -1, ne_1: 15, ne_2: 21, ne_3: -1, ne_4: 18,
                ne_5: 8},
          7 => {i: 7, type: 1, res: 26, ne_0: 17, ne_1: 19, ne_2: 9, ne_3: 1, ne_4: -1,
                ne_5: 5},
          8 => {i: 8, type: 1, res: 26, ne_0: 2, ne_1: -1, ne_2: 6, ne_3: 18, ne_4: 20,
                ne_5: 10},
          9 => {i: 9, type: 0, res: 0, ne_0: 19, ne_1: -1, ne_2: -1, ne_3: 11, ne_4: 1,
                ne_5: 7},
          10 => {i: 10, type: 0, res: 0, ne_0: 12, ne_1: 2, ne_2: 8, ne_3: 20, ne_4: -1,
                 ne_5: -1},
          11 => {i: 11, type: 2, res: 265, ne_0: 9, ne_1: -1, ne_2: -1, ne_3: 13, ne_4: 3,
                 ne_5: 1},
          12 => {i: 12, type: 2, res: 265, ne_0: 14, ne_1: 4, ne_2: 2, ne_3: 10, ne_4: -1,
                 ne_5: -1},
          13 => {i: 13, type: 2, res: 65, ne_0: 11, ne_1: -1, ne_2: -1, ne_3: -1, ne_4: 15,
                 ne_5: 3},
          14 => {i: 14, type: 2, res: 65, ne_0: -1, ne_1: 16, ne_2: 4, ne_3: 12, ne_4: -1,
                 ne_5: -1},
          15 => {i: 15, type: 0, res: 0, ne_0: 3, ne_1: 13, ne_2: -1, ne_3: 21, ne_4: 6,
                 ne_5: -1},
          16 => {i: 16, type: 0, res: 0, ne_0: 22, ne_1: 5, ne_2: -1, ne_3: 4, ne_4: 14,
                 ne_5: -1},
          17 => {i: 17, type: 1, res: 24, ne_0: 25, ne_1: 27, ne_2: 19, ne_3: 7, ne_4: 5,
                 ne_5: -1},
          18 => {i: 18, type: 1, res: 24, ne_0: 8, ne_1: 6, ne_2: -1, ne_3: 26, ne_4: 28,
                 ne_5: 20},
          19 => {i: 19, type: 0, res: 0, ne_0: 27, ne_1: -1, ne_2: -1, ne_3: 9, ne_4: 7,
                 ne_5: 17},
          20 => {i: 20, type: 0, res: 0, ne_0: 10, ne_1: 8, ne_2: 18, ne_3: 28, ne_4: -1,
                 ne_5: -1},
          27 => {i: 27, type: 0, res: 0, ne_0: -1, ne_1: -1, ne_2: -1, ne_3: 19, ne_4: 17,
                 ne_5: 25},
          28 => {i: 28, type: 0, res: 0, ne_0: 20, ne_1: 18, ne_2: 26, ne_3: -1, ne_4: -1,
                 ne_5: -1}
        }
      end

      let(:my_base_indices) { [4] }
      let(:opp_base_indices) { [3] }

      context "when nothing is contested and the logical move is to gather eggs" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>4, :res=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>26, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>26, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0}
          ]
        end

        it "returns a decision to go for the closest eggs" do
          is_expected.to eq("BEACON 4 3000; BEACON 2 3000; BEACON 8 4000; MESSAGE close eggs on 8")
        end
      end

      context "when there's an opportunity to expand to neighboring cells" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>3},
            {:i=>2, :res=>0, :my_ants=>3, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>7},
            {:i=>4, :res=>0, :my_ants=>6, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>23, :my_ants=>0, :opp_ants=>3},
            {:i=>8, :res=>23, :my_ants=>4, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to expand" do
          is_expected.to eq("BEACON 4 3077; BEACON 2 3077; BEACON 8 3846; BEACON 18 3077; MESSAGE Expanding on egg gathering")
        end
      end

      context "when I've just gathered my half of eggs and should just go for mineral win" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>2, :res=>0, :my_ants=>18, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>4, :res=>0, :my_ants=>20, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>0, :my_ants=>0, :opp_ants=>14},
            {:i=>8, :res=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>20, :my_ants=>0, :opp_ants=>4},
            {:i=>18, :res=>0, :my_ants=>9, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to mine closest, best minerals" do
          is_expected.to eq("LINE 4 11 100; LINE 4 12 100; LINE 4 13 100; LINE 4 14 100; MESSAGE yeehaw")
        end
      end

      context "when current ant allocation will-gather and can be spread better" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>14},
            {:i=>2, :res=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>4, :res=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>8, :res=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>24, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>7, :my_ants=>8, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
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
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>30},
            {:i=>4, :res=>0, :my_ants=>30, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>55, :my_ants=>0, :opp_ants=>30},
            {:i=>12, :res=>0, :my_ants=>30, :opp_ants=>0},
            {:i=>13, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to proceed with mining" do
          is_expected.to eq("LINE 4 11 100; LINE 4 13 100; LINE 4 14 100; MESSAGE yeehaw")
        end
      end

      context "when we're at the mining stage and could expand on a nearby cell" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>2, :res=>0, :my_ants=>15, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>4, :res=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>0, :my_ants=>0, :opp_ants=>14},
            {:i=>8, :res=>0, :my_ants=>11, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>265, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>260, :my_ants=>5, :opp_ants=>0},
            {:i=>13, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>20, :my_ants=>0, :opp_ants=>4},
            {:i=>18, :res=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to beacon the nearby mineral patches also" do
          is_expected.to eq(
            "LINE 4 11 100; LINE 4 12 100; LINE 4 13 100; LINE 4 14 100; MESSAGE yeehaw"
          )
        end
      end
    end

    context "when seed=-1636922316538223000, bases are very far, init is slow" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>1, :ne_2=>3, :ne_3=>-1, :ne_4=>2, :ne_5=>4},
          1 => {:i=>1, :type=>1, :res=>11, :ne_0=>7, :ne_1=>9, :ne_2=>11, :ne_3=>3, :ne_4=>0, :ne_5=>-1},
          2 => {:i=>2, :type=>1, :res=>11, :ne_0=>4, :ne_1=>0, :ne_2=>-1, :ne_3=>8, :ne_4=>10, :ne_5=>12},
          3 => {:i=>3, :type=>0, :res=>0, :ne_0=>1, :ne_1=>11, :ne_2=>13, :ne_3=>-1, :ne_4=>-1, :ne_5=>0},
          4 => {:i=>4, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>0, :ne_3=>2, :ne_4=>12, :ne_5=>14},
          5 => {:i=>5, :type=>0, :res=>0, :ne_0=>15, :ne_1=>17, :ne_2=>7, :ne_3=>-1, :ne_4=>-1, :ne_5=>24},
          6 => {:i=>6, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>23, :ne_3=>16, :ne_4=>18, :ne_5=>8},
          7 => {:i=>7, :type=>1, :res=>29, :ne_0=>17, :ne_1=>19, :ne_2=>9, :ne_3=>1, :ne_4=>-1, :ne_5=>5},
          8 => {:i=>8, :type=>1, :res=>29, :ne_0=>2, :ne_1=>-1, :ne_2=>6, :ne_3=>18, :ne_4=>20, :ne_5=>10},
          9 => {:i=>9, :type=>2, :res=>85, :ne_0=>19, :ne_1=>-1, :ne_2=>-1, :ne_3=>11, :ne_4=>1, :ne_5=>7},
          10 => {:i=>10, :type=>2, :res=>85, :ne_0=>12, :ne_1=>2, :ne_2=>8, :ne_3=>20, :ne_4=>-1, :ne_5=>-1},
          11 => {:i=>11, :type=>0, :res=>0, :ne_0=>9, :ne_1=>-1, :ne_2=>-1, :ne_3=>13, :ne_4=>3, :ne_5=>1},
          12 => {:i=>12, :type=>0, :res=>0, :ne_0=>14, :ne_1=>4, :ne_2=>2, :ne_3=>10, :ne_4=>-1, :ne_5=>-1},
          13 => {:i=>13, :type=>1, :res=>12, :ne_0=>11, :ne_1=>-1, :ne_2=>-1, :ne_3=>21, :ne_4=>-1, :ne_5=>3},
          14 => {:i=>14, :type=>1, :res=>12, :ne_0=>22, :ne_1=>-1, :ne_2=>4, :ne_3=>12, :ne_4=>-1, :ne_5=>-1},
          15 => {:i=>15, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>25, :ne_2=>17, :ne_3=>5, :ne_4=>24, :ne_5=>30},
          16 => {:i=>16, :type=>0, :res=>0, :ne_0=>6, :ne_1=>23, :ne_2=>29, :ne_3=>-1, :ne_4=>26, :ne_5=>18},
          17 => {:i=>17, :type=>0, :res=>0, :ne_0=>25, :ne_1=>-1, :ne_2=>19, :ne_3=>7, :ne_4=>5, :ne_5=>15},
          18 => {:i=>18, :type=>0, :res=>0, :ne_0=>8, :ne_1=>6, :ne_2=>16, :ne_3=>26, :ne_4=>-1, :ne_5=>20},
          19 => {:i=>19, :type=>1, :res=>31, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>9, :ne_4=>7, :ne_5=>17},
          20 => {:i=>20, :type=>1, :res=>31, :ne_0=>10, :ne_1=>8, :ne_2=>18, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          21 => {:i=>21, :type=>0, :res=>0, :ne_0=>13, :ne_1=>-1, :ne_2=>-1, :ne_3=>27, :ne_4=>23, :ne_5=>-1},
          22 => {:i=>22, :type=>0, :res=>0, :ne_0=>28, :ne_1=>24, :ne_2=>-1, :ne_3=>14, :ne_4=>-1, :ne_5=>-1},
          23 => {:i=>23, :type=>2, :res=>230, :ne_0=>-1, :ne_1=>21, :ne_2=>27, :ne_3=>29, :ne_4=>16, :ne_5=>6},
          24 => {:i=>24, :type=>2, :res=>230, :ne_0=>30, :ne_1=>15, :ne_2=>5, :ne_3=>-1, :ne_4=>22, :ne_5=>28},
          25 => {:i=>25, :type=>0, :res=>0, :ne_0=>33, :ne_1=>35, :ne_2=>-1, :ne_3=>17, :ne_4=>15, :ne_5=>-1},
          26 => {:i=>26, :type=>0, :res=>0, :ne_0=>18, :ne_1=>16, :ne_2=>-1, :ne_3=>34, :ne_4=>36, :ne_5=>-1},
          27 => {:i=>27, :type=>2, :res=>280, :ne_0=>21, :ne_1=>-1, :ne_2=>-1, :ne_3=>37, :ne_4=>29, :ne_5=>23},
          28 => {:i=>28, :type=>2, :res=>280, :ne_0=>38, :ne_1=>30, :ne_2=>24, :ne_3=>22, :ne_4=>-1, :ne_5=>-1},
          29 => {:i=>29, :type=>0, :res=>0, :ne_0=>23, :ne_1=>27, :ne_2=>37, :ne_3=>39, :ne_4=>-1, :ne_5=>16},
          30 => {:i=>30, :type=>0, :res=>0, :ne_0=>40, :ne_1=>-1, :ne_2=>15, :ne_3=>24, :ne_4=>28, :ne_5=>38},
          31 => {:i=>31, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>33, :ne_3=>-1, :ne_4=>40, :ne_5=>-1},
          32 => {:i=>32, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>39, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>34},
          33 => {:i=>33, :type=>2, :res=>85, :ne_0=>-1, :ne_1=>-1, :ne_2=>35, :ne_3=>25, :ne_4=>-1, :ne_5=>31},
          34 => {:i=>34, :type=>2, :res=>85, :ne_0=>26, :ne_1=>-1, :ne_2=>32, :ne_3=>-1, :ne_4=>-1, :ne_5=>36},
          35 => {:i=>35, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>25, :ne_5=>33},
          36 => {:i=>36, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>26, :ne_2=>34, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          37 => {:i=>37, :type=>0, :res=>0, :ne_0=>27, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>39, :ne_5=>29},
          38 => {:i=>38, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>40, :ne_2=>30, :ne_3=>28, :ne_4=>-1, :ne_5=>-1},
          39 => {:i=>39, :type=>0, :res=>0, :ne_0=>29, :ne_1=>37, :ne_2=>-1, :ne_3=>-1, :ne_4=>32, :ne_5=>-1},
          40 => {:i=>40, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>31, :ne_2=>-1, :ne_3=>30, :ne_4=>38, :ne_5=>-1},
        }
      end

      let(:my_base_indices) { [39] }
      let(:opp_base_indices) { [40] }

      let(:cell_updates) do
        [
          {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>1, :res=>11, :my_ants=>0, :opp_ants=>0},
          {:i=>2, :res=>11, :my_ants=>0, :opp_ants=>0},
          {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>7, :res=>29, :my_ants=>0, :opp_ants=>0},
          {:i=>8, :res=>29, :my_ants=>0, :opp_ants=>0},
          {:i=>9, :res=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>10, :res=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>13, :res=>12, :my_ants=>0, :opp_ants=>0},
          {:i=>14, :res=>12, :my_ants=>0, :opp_ants=>0},
          {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>17, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>18, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>19, :res=>31, :my_ants=>0, :opp_ants=>0},
          {:i=>20, :res=>31, :my_ants=>0, :opp_ants=>0},
          {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>23, :res=>230, :my_ants=>0, :opp_ants=>0},
          {:i=>24, :res=>230, :my_ants=>0, :opp_ants=>0},
          {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>27, :res=>280, :my_ants=>0, :opp_ants=>0},
          {:i=>28, :res=>280, :my_ants=>0, :opp_ants=>0},
          {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>32, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>33, :res=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>34, :res=>85, :my_ants=>0, :opp_ants=>0},
          {:i=>35, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>36, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>37, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>38, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>39, :res=>0, :my_ants=>10, :opp_ants=>0},
          {:i=>40, :res=>0, :my_ants=>0, :opp_ants=>10},
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
          0 => {:i=>0, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>1, :ne_3=>-1, :ne_4=>-1, :ne_5=>2},
          1 => {:i=>1, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>9, :ne_2=>11, :ne_3=>13, :ne_4=>-1, :ne_5=>0},
          2 => {:i=>2, :type=>0, :res=>0, :ne_0=>14, :ne_1=>-1, :ne_2=>0, :ne_3=>-1, :ne_4=>10, :ne_5=>12},
          3 => {:i=>3, :type=>0, :res=>0, :ne_0=>15, :ne_1=>17, :ne_2=>5, :ne_3=>-1, :ne_4=>14, :ne_5=>22},
          4 => {:i=>4, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>13, :ne_2=>21, :ne_3=>16, :ne_4=>18, :ne_5=>6},
          5 => {:i=>5, :type=>1, :res=>17, :ne_0=>17, :ne_1=>19, :ne_2=>7, :ne_3=>-1, :ne_4=>-1, :ne_5=>3},
          6 => {:i=>6, :type=>1, :res=>17, :ne_0=>-1, :ne_1=>-1, :ne_2=>4, :ne_3=>18, :ne_4=>20, :ne_5=>8},
          7 => {:i=>7, :type=>0, :res=>0, :ne_0=>19, :ne_1=>-1, :ne_2=>-1, :ne_3=>9, :ne_4=>-1, :ne_5=>5},
          8 => {:i=>8, :type=>0, :res=>0, :ne_0=>10, :ne_1=>-1, :ne_2=>6, :ne_3=>20, :ne_4=>-1, :ne_5=>-1},
          9 => {:i=>9, :type=>0, :res=>0, :ne_0=>7, :ne_1=>-1, :ne_2=>-1, :ne_3=>11, :ne_4=>1, :ne_5=>-1},
          10 => {:i=>10, :type=>0, :res=>0, :ne_0=>12, :ne_1=>2, :ne_2=>-1, :ne_3=>8, :ne_4=>-1, :ne_5=>-1},
          11 => {:i=>11, :type=>0, :res=>0, :ne_0=>9, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>13, :ne_5=>1},
          12 => {:i=>12, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>14, :ne_2=>2, :ne_3=>10, :ne_4=>-1, :ne_5=>-1},
          13 => {:i=>13, :type=>1, :res=>12, :ne_0=>1, :ne_1=>11, :ne_2=>-1, :ne_3=>21, :ne_4=>4, :ne_5=>-1},
          14 => {:i=>14, :type=>1, :res=>12, :ne_0=>22, :ne_1=>3, :ne_2=>-1, :ne_3=>2, :ne_4=>12, :ne_5=>-1},
          15 => {:i=>15, :type=>0, :res=>0, :ne_0=>23, :ne_1=>-1, :ne_2=>17, :ne_3=>3, :ne_4=>22, :ne_5=>30},
          16 => {:i=>16, :type=>0, :res=>0, :ne_0=>4, :ne_1=>21, :ne_2=>29, :ne_3=>24, :ne_4=>-1, :ne_5=>18},
          17 => {:i=>17, :type=>2, :res=>90, :ne_0=>-1, :ne_1=>25, :ne_2=>19, :ne_3=>5, :ne_4=>3, :ne_5=>15},
          18 => {:i=>18, :type=>2, :res=>90, :ne_0=>6, :ne_1=>4, :ne_2=>16, :ne_3=>-1, :ne_4=>26, :ne_5=>20},
          19 => {:i=>19, :type=>0, :res=>0, :ne_0=>25, :ne_1=>-1, :ne_2=>-1, :ne_3=>7, :ne_4=>5, :ne_5=>17},
          20 => {:i=>20, :type=>0, :res=>0, :ne_0=>8, :ne_1=>6, :ne_2=>18, :ne_3=>26, :ne_4=>-1, :ne_5=>-1},
          21 => {:i=>21, :type=>0, :res=>0, :ne_0=>13, :ne_1=>-1, :ne_2=>27, :ne_3=>29, :ne_4=>16, :ne_5=>4},
          22 => {:i=>22, :type=>0, :res=>0, :ne_0=>30, :ne_1=>15, :ne_2=>3, :ne_3=>14, :ne_4=>-1, :ne_5=>28},
          23 => {:i=>23, :type=>2, :res=>250, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>15, :ne_4=>30, :ne_5=>-1},
          24 => {:i=>24, :type=>2, :res=>250, :ne_0=>16, :ne_1=>29, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          25 => {:i=>25, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>19, :ne_4=>17, :ne_5=>-1},
          26 => {:i=>26, :type=>0, :res=>0, :ne_0=>20, :ne_1=>18, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          27 => {:i=>27, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>29, :ne_5=>21},
          28 => {:i=>28, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>30, :ne_2=>22, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          29 => {:i=>29, :type=>0, :res=>0, :ne_0=>21, :ne_1=>27, :ne_2=>-1, :ne_3=>-1, :ne_4=>24, :ne_5=>16},
          30 => {:i=>30, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>23, :ne_2=>15, :ne_3=>22, :ne_4=>28, :ne_5=>-1},
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
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>23, :res=>250, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>250, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to go for the closest eggs" do
          is_expected.to eq("LINE 21 13 1; MESSAGE Egg next to base, yay")
        end
      end

      context "when it's further along into the game and egg gathering is about to conclude" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>4, :res=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>5, :res=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>3, :my_ants=>7, :opp_ants=>0},
            {:i=>7, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>6},
            {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>86, :my_ants=>0, :opp_ants=>2},
            {:i=>18, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>16, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>23, :res=>246, :my_ants=>0, :opp_ants=>2},
            {:i=>24, :res=>250, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
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
          0 => {:i=>0, :type=>0, :res=>0, :ne_0=>1, :ne_1=>3, :ne_2=>-1, :ne_3=>2, :ne_4=>4, :ne_5=>-1},
          1 => {:i=>1, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>5, :ne_2=>3, :ne_3=>0, :ne_4=>-1, :ne_5=>14},
          2 => {:i=>2, :type=>0, :res=>0, :ne_0=>0, :ne_1=>-1, :ne_2=>13, :ne_3=>-1, :ne_4=>6, :ne_5=>4},
          3 => {:i=>3, :type=>0, :res=>0, :ne_0=>5, :ne_1=>7, :ne_2=>9, :ne_3=>-1, :ne_4=>0, :ne_5=>1},
          4 => {:i=>4, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>0, :ne_2=>2, :ne_3=>6, :ne_4=>8, :ne_5=>10},
          5 => {:i=>5, :type=>0, :res=>0, :ne_0=>17, :ne_1=>19, :ne_2=>7, :ne_3=>3, :ne_4=>1, :ne_5=>-1},
          6 => {:i=>6, :type=>0, :res=>0, :ne_0=>4, :ne_1=>2, :ne_2=>-1, :ne_3=>18, :ne_4=>20, :ne_5=>8},
          7 => {:i=>7, :type=>2, :res=>245, :ne_0=>19, :ne_1=>-1, :ne_2=>-1, :ne_3=>9, :ne_4=>3, :ne_5=>5},
          8 => {:i=>8, :type=>2, :res=>245, :ne_0=>10, :ne_1=>4, :ne_2=>6, :ne_3=>20, :ne_4=>-1, :ne_5=>-1},
          9 => {:i=>9, :type=>0, :res=>0, :ne_0=>7, :ne_1=>-1, :ne_2=>-1, :ne_3=>11, :ne_4=>-1, :ne_5=>3},
          10 => {:i=>10, :type=>0, :res=>0, :ne_0=>12, :ne_1=>-1, :ne_2=>4, :ne_3=>8, :ne_4=>-1, :ne_5=>-1},
          11 => {:i=>11, :type=>0, :res=>0, :ne_0=>9, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>13, :ne_5=>-1},
          12 => {:i=>12, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>14, :ne_2=>-1, :ne_3=>10, :ne_4=>-1, :ne_5=>-1},
          13 => {:i=>13, :type=>1, :res=>18, :ne_0=>-1, :ne_1=>11, :ne_2=>-1, :ne_3=>21, :ne_4=>-1, :ne_5=>2},
          14 => {:i=>14, :type=>1, :res=>18, :ne_0=>22, :ne_1=>-1, :ne_2=>1, :ne_3=>-1, :ne_4=>12, :ne_5=>-1},
          15 => {:i=>15, :type=>1, :res=>19, :ne_0=>23, :ne_1=>25, :ne_2=>17, :ne_3=>-1, :ne_4=>22, :ne_5=>32},
          16 => {:i=>16, :type=>1, :res=>19, :ne_0=>-1, :ne_1=>21, :ne_2=>31, :ne_3=>24, :ne_4=>26, :ne_5=>18},
          17 => {:i=>17, :type=>0, :res=>0, :ne_0=>25, :ne_1=>27, :ne_2=>19, :ne_3=>5, :ne_4=>-1, :ne_5=>15},
          18 => {:i=>18, :type=>0, :res=>0, :ne_0=>6, :ne_1=>-1, :ne_2=>16, :ne_3=>26, :ne_4=>28, :ne_5=>20},
          19 => {:i=>19, :type=>1, :res=>17, :ne_0=>27, :ne_1=>-1, :ne_2=>-1, :ne_3=>7, :ne_4=>5, :ne_5=>17},
          20 => {:i=>20, :type=>1, :res=>17, :ne_0=>8, :ne_1=>6, :ne_2=>18, :ne_3=>28, :ne_4=>-1, :ne_5=>-1},
          21 => {:i=>21, :type=>0, :res=>0, :ne_0=>13, :ne_1=>-1, :ne_2=>29, :ne_3=>31, :ne_4=>16, :ne_5=>-1},
          22 => {:i=>22, :type=>0, :res=>0, :ne_0=>32, :ne_1=>15, :ne_2=>-1, :ne_3=>14, :ne_4=>-1, :ne_5=>30},
          23 => {:i=>23, :type=>2, :res=>260, :ne_0=>-1, :ne_1=>-1, :ne_2=>25, :ne_3=>15, :ne_4=>32, :ne_5=>-1},
          24 => {:i=>24, :type=>2, :res=>260, :ne_0=>16, :ne_1=>31, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>26},
          25 => {:i=>25, :type=>1, :res=>27, :ne_0=>-1, :ne_1=>-1, :ne_2=>27, :ne_3=>17, :ne_4=>15, :ne_5=>23},
          26 => {:i=>26, :type=>1, :res=>27, :ne_0=>18, :ne_1=>16, :ne_2=>24, :ne_3=>-1, :ne_4=>-1, :ne_5=>28},
          27 => {:i=>27, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>19, :ne_4=>17, :ne_5=>25},
          28 => {:i=>28, :type=>0, :res=>0, :ne_0=>20, :ne_1=>18, :ne_2=>26, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          29 => {:i=>29, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>31, :ne_5=>21},
          30 => {:i=>30, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>32, :ne_2=>22, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          31 => {:i=>31, :type=>0, :res=>0, :ne_0=>21, :ne_1=>29, :ne_2=>-1, :ne_3=>-1, :ne_4=>24, :ne_5=>16},
          32 => {:i=>32, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>23, :ne_2=>15, :ne_3=>22, :ne_4=>30, :ne_5=>-1},
        }
      end

      let(:my_base_indices) { [18] }
      let(:opp_base_indices) { [17] }

      context "when there's a cluster of eggs next to base" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>19, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>19, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>18, :res=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>19, :res=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>17, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>27, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>27, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to efficiently gather those" do
          is_expected.to eq("LINE 18 16 1; LINE 18 20 1; LINE 18 26 1; MESSAGE Eggs next to base, yay")
        end
      end

      context "when eggs next to base are mining out" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>5},
            {:i=>16, :res=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>17, :res=>0, :my_ants=>0, :opp_ants=>16},
            {:i=>18, :res=>0, :my_ants=>34, :opp_ants=>0},
            {:i=>19, :res=>7, :my_ants=>0, :opp_ants=>14},
            {:i=>20, :res=>0, :my_ants=>12, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>22, :my_ants=>0, :opp_ants=>9},
            {:i=>26, :res=>2, :my_ants=>12, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to expand to nearby crystals while grapsing for contested eggs" do
          is_expected.to eq("BEACON 26 9; LINE 18 13 10; LINE 18 8 10; LINE 18 24 10; MESSAGE opportune crossfading eggs to further egg gather")
        end
      end

      context "when we've opportunistically expanded to minerals, but the main focus should remain eggs" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>7, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>236, :my_ants=>9, :opp_ants=>0},
            {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>18, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>16, :opp_ants=>0},
            {:i=>17, :res=>0, :my_ants=>0, :opp_ants=>35},
            {:i=>18, :res=>0, :my_ants=>12, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>11},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>260, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>252, :my_ants=>8, :opp_ants=>0},
            {:i=>25, :res=>8, :my_ants=>0, :opp_ants=>19},
            {:i=>26, :res=>0, :my_ants=>9, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to line to eggs AND preserve a minimal effort at minerals also" do
          is_expected.to eq("BEACON 18 2466; BEACON 6 2466; BEACON 2 2466; BEACON 13 2603; MESSAGE close eggs on 13")
        end
      end
    end

    context "when seed= with bases far apart and there being atari" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>2, :res=>48, :ne_0=>1, :ne_1=>3, :ne_2=>-1, :ne_3=>2, :ne_4=>4, :ne_5=>-1},
          1 => {:i=>1, :type=>0, :res=>0, :ne_0=>5, :ne_1=>-1, :ne_2=>3, :ne_3=>0, :ne_4=>-1, :ne_5=>14},
          2 => {:i=>2, :type=>0, :res=>0, :ne_0=>0, :ne_1=>-1, :ne_2=>13, :ne_3=>6, :ne_4=>-1, :ne_5=>4},
          3 => {:i=>3, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>7, :ne_2=>9, :ne_3=>-1, :ne_4=>0, :ne_5=>1},
          4 => {:i=>4, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>0, :ne_2=>2, :ne_3=>-1, :ne_4=>8, :ne_5=>10},
          5 => {:i=>5, :type=>0, :res=>0, :ne_0=>15, :ne_1=>17, :ne_2=>-1, :ne_3=>1, :ne_4=>14, :ne_5=>24},
          6 => {:i=>6, :type=>0, :res=>0, :ne_0=>2, :ne_1=>13, :ne_2=>23, :ne_3=>16, :ne_4=>18, :ne_5=>-1},
          7 => {:i=>7, :type=>2, :res=>280, :ne_0=>19, :ne_1=>-1, :ne_2=>-1, :ne_3=>9, :ne_4=>3, :ne_5=>-1},
          8 => {:i=>8, :type=>2, :res=>280, :ne_0=>10, :ne_1=>4, :ne_2=>-1, :ne_3=>20, :ne_4=>-1, :ne_5=>-1},
          9 => {:i=>9, :type=>1, :res=>10, :ne_0=>7, :ne_1=>-1, :ne_2=>-1, :ne_3=>11, :ne_4=>-1, :ne_5=>3},
          10 => {:i=>10, :type=>1, :res=>10, :ne_0=>12, :ne_1=>-1, :ne_2=>4, :ne_3=>8, :ne_4=>-1, :ne_5=>-1},
          11 => {:i=>11, :type=>2, :res=>210, :ne_0=>9, :ne_1=>-1, :ne_2=>-1, :ne_3=>21, :ne_4=>13, :ne_5=>-1},
          12 => {:i=>12, :type=>2, :res=>210, :ne_0=>22, :ne_1=>14, :ne_2=>-1, :ne_3=>10, :ne_4=>-1, :ne_5=>-1},
          13 => {:i=>13, :type=>1, :res=>12, :ne_0=>-1, :ne_1=>11, :ne_2=>21, :ne_3=>23, :ne_4=>6, :ne_5=>2},
          14 => {:i=>14, :type=>1, :res=>12, :ne_0=>24, :ne_1=>5, :ne_2=>1, :ne_3=>-1, :ne_4=>12, :ne_5=>22},
          15 => {:i=>15, :type=>0, :res=>0, :ne_0=>25, :ne_1=>27, :ne_2=>17, :ne_3=>5, :ne_4=>24, :ne_5=>-1},
          16 => {:i=>16, :type=>0, :res=>0, :ne_0=>6, :ne_1=>23, :ne_2=>-1, :ne_3=>26, :ne_4=>28, :ne_5=>18},
          17 => {:i=>17, :type=>2, :res=>90, :ne_0=>27, :ne_1=>29, :ne_2=>19, :ne_3=>-1, :ne_4=>5, :ne_5=>15},
          18 => {:i=>18, :type=>2, :res=>90, :ne_0=>-1, :ne_1=>6, :ne_2=>16, :ne_3=>28, :ne_4=>30, :ne_5=>20},
          19 => {:i=>19, :type=>0, :res=>0, :ne_0=>29, :ne_1=>-1, :ne_2=>-1, :ne_3=>7, :ne_4=>-1, :ne_5=>17},
          20 => {:i=>20, :type=>0, :res=>0, :ne_0=>8, :ne_1=>-1, :ne_2=>18, :ne_3=>30, :ne_4=>-1, :ne_5=>-1},
          21 => {:i=>21, :type=>1, :res=>39, :ne_0=>11, :ne_1=>-1, :ne_2=>-1, :ne_3=>31, :ne_4=>23, :ne_5=>13},
          22 => {:i=>22, :type=>1, :res=>39, :ne_0=>32, :ne_1=>24, :ne_2=>14, :ne_3=>12, :ne_4=>-1, :ne_5=>-1},
          23 => {:i=>23, :type=>0, :res=>0, :ne_0=>13, :ne_1=>21, :ne_2=>31, :ne_3=>-1, :ne_4=>16, :ne_5=>6},
          24 => {:i=>24, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>15, :ne_2=>5, :ne_3=>14, :ne_4=>22, :ne_5=>32},
          25 => {:i=>25, :type=>2, :res=>245, :ne_0=>33, :ne_1=>35, :ne_2=>27, :ne_3=>15, :ne_4=>-1, :ne_5=>42},
          26 => {:i=>26, :type=>2, :res=>245, :ne_0=>16, :ne_1=>-1, :ne_2=>41, :ne_3=>34, :ne_4=>36, :ne_5=>28},
          27 => {:i=>27, :type=>0, :res=>0, :ne_0=>35, :ne_1=>37, :ne_2=>29, :ne_3=>17, :ne_4=>15, :ne_5=>25},
          28 => {:i=>28, :type=>0, :res=>0, :ne_0=>18, :ne_1=>16, :ne_2=>26, :ne_3=>36, :ne_4=>38, :ne_5=>30},
          29 => {:i=>29, :type=>0, :res=>0, :ne_0=>37, :ne_1=>-1, :ne_2=>-1, :ne_3=>19, :ne_4=>17, :ne_5=>27},
          30 => {:i=>30, :type=>0, :res=>0, :ne_0=>20, :ne_1=>18, :ne_2=>28, :ne_3=>38, :ne_4=>-1, :ne_5=>-1},
          31 => {:i=>31, :type=>0, :res=>0, :ne_0=>21, :ne_1=>-1, :ne_2=>-1, :ne_3=>39, :ne_4=>-1, :ne_5=>23},
          32 => {:i=>32, :type=>0, :res=>0, :ne_0=>40, :ne_1=>-1, :ne_2=>24, :ne_3=>22, :ne_4=>-1, :ne_5=>-1},
          33 => {:i=>33, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>35, :ne_3=>25, :ne_4=>42, :ne_5=>-1},
          34 => {:i=>34, :type=>0, :res=>0, :ne_0=>26, :ne_1=>41, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>36},
          35 => {:i=>35, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>37, :ne_3=>27, :ne_4=>25, :ne_5=>33},
          36 => {:i=>36, :type=>0, :res=>0, :ne_0=>28, :ne_1=>26, :ne_2=>34, :ne_3=>-1, :ne_4=>-1, :ne_5=>38},
          37 => {:i=>37, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>29, :ne_4=>27, :ne_5=>35},
          38 => {:i=>38, :type=>0, :res=>0, :ne_0=>30, :ne_1=>28, :ne_2=>36, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          39 => {:i=>39, :type=>0, :res=>0, :ne_0=>31, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>41, :ne_5=>-1},
          40 => {:i=>40, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>42, :ne_2=>-1, :ne_3=>32, :ne_4=>-1, :ne_5=>-1},
          41 => {:i=>41, :type=>1, :res=>10, :ne_0=>-1, :ne_1=>39, :ne_2=>-1, :ne_3=>-1, :ne_4=>34, :ne_5=>26},
          42 => {:i=>42, :type=>1, :res=>10, :ne_0=>-1, :ne_1=>33, :ne_2=>25, :ne_3=>-1, :ne_4=>40, :ne_5=>-1},
        }
      end

      let(:my_base_indices) { [40] }
      let(:opp_base_indices) { [39] }

      context "when it's the first move and there are egss next to base" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>48, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>280, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>280, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>210, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>210, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>12, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>39, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>39, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>245, :my_ants=>0, :opp_ants=>0},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>32, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>33, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>34, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>35, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>36, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>37, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>38, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>39, :res=>0, :my_ants=>0, :opp_ants=>10},
            {:i=>40, :res=>0, :my_ants=>10, :opp_ants=>0},
            {:i=>41, :res=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>42, :res=>10, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns command to just go for the eggs " do
          is_expected.to eq("LINE 40 42 1; MESSAGE Egg next to base, yay")
        end
      end

      context "when I've got all my eggs and there are a bunch of minerals left to get" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>48, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>7},
            {:i=>7, :res=>280, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>280, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>10, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>0, :my_ants=>17, :opp_ants=>0},
            {:i=>11, :res=>210, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>174, :my_ants=>18, :opp_ants=>0},
            {:i=>13, :res=>0, :my_ants=>0, :opp_ants=>4},
            {:i=>14, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>90, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>5},
            {:i=>22, :res=>0, :my_ants=>12, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>2},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>239, :my_ants=>0, :opp_ants=>0},
            {:i=>26, :res=>187, :my_ants=>0, :opp_ants=>9},
            {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>8},
            {:i=>32, :res=>0, :my_ants=>19, :opp_ants=>0},
            {:i=>33, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>34, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>35, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>36, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>37, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>38, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>39, :res=>0, :my_ants=>0, :opp_ants=>27},
            {:i=>40, :res=>0, :my_ants=>15, :opp_ants=>0},
            {:i=>41, :res=>0, :my_ants=>0, :opp_ants=>9},
            {:i=>42, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a command to gather from everywhere" do
          is_expected.to eq(
            "LINE 40 0 100; LINE 40 7 100; LINE 40 8 100; LINE 40 11 100; LINE 40 12 100; LINE 40 17 100; LINE 40 18 100; LINE 40 25 100; LINE 40 26 100; " \
            "MESSAGE yeehaw"
          )
        end
      end
    end

    context "when seed=-4289027747010759700 and its a real simple eggs-near-base then minerals map" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>2, :res=>56, :ne_0=>-1, :ne_1=>1, :ne_2=>3, :ne_3=>-1, :ne_4=>2, :ne_5=>4},
          1 => {:i=>1, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>7, :ne_2=>9, :ne_3=>3, :ne_4=>0, :ne_5=>-1},
          2 => {:i=>2, :type=>0, :res=>0, :ne_0=>4, :ne_1=>0, :ne_2=>-1, :ne_3=>-1, :ne_4=>8, :ne_5=>10},
          3 => {:i=>3, :type=>0, :res=>0, :ne_0=>1, :ne_1=>9, :ne_2=>11, :ne_3=>13, :ne_4=>-1, :ne_5=>0},
          4 => {:i=>4, :type=>0, :res=>0, :ne_0=>14, :ne_1=>-1, :ne_2=>0, :ne_3=>2, :ne_4=>10, :ne_5=>12},
          5 => {:i=>5, :type=>0, :res=>0, :ne_0=>15, :ne_1=>17, :ne_2=>-1, :ne_3=>-1, :ne_4=>14, :ne_5=>24},
          6 => {:i=>6, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>13, :ne_2=>23, :ne_3=>16, :ne_4=>18, :ne_5=>-1},
          7 => {:i=>7, :type=>2, :res=>290, :ne_0=>19, :ne_1=>-1, :ne_2=>-1, :ne_3=>9, :ne_4=>1, :ne_5=>-1},
          8 => {:i=>8, :type=>2, :res=>290, :ne_0=>10, :ne_1=>2, :ne_2=>-1, :ne_3=>20, :ne_4=>-1, :ne_5=>-1},
          9 => {:i=>9, :type=>0, :res=>0, :ne_0=>7, :ne_1=>-1, :ne_2=>-1, :ne_3=>11, :ne_4=>3, :ne_5=>1},
          10 => {:i=>10, :type=>0, :res=>0, :ne_0=>12, :ne_1=>4, :ne_2=>2, :ne_3=>8, :ne_4=>-1, :ne_5=>-1},
          11 => {:i=>11, :type=>0, :res=>0, :ne_0=>9, :ne_1=>-1, :ne_2=>-1, :ne_3=>21, :ne_4=>13, :ne_5=>3},
          12 => {:i=>12, :type=>0, :res=>0, :ne_0=>22, :ne_1=>14, :ne_2=>4, :ne_3=>10, :ne_4=>-1, :ne_5=>-1},
          13 => {:i=>13, :type=>0, :res=>0, :ne_0=>3, :ne_1=>11, :ne_2=>21, :ne_3=>23, :ne_4=>6, :ne_5=>-1},
          14 => {:i=>14, :type=>0, :res=>0, :ne_0=>24, :ne_1=>5, :ne_2=>-1, :ne_3=>4, :ne_4=>12, :ne_5=>22},
          15 => {:i=>15, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>25, :ne_2=>17, :ne_3=>5, :ne_4=>24, :ne_5=>-1},
          16 => {:i=>16, :type=>0, :res=>0, :ne_0=>6, :ne_1=>23, :ne_2=>-1, :ne_3=>-1, :ne_4=>26, :ne_5=>18},
          17 => {:i=>17, :type=>2, :res=>40, :ne_0=>25, :ne_1=>-1, :ne_2=>19, :ne_3=>-1, :ne_4=>5, :ne_5=>15},
          18 => {:i=>18, :type=>2, :res=>40, :ne_0=>-1, :ne_1=>6, :ne_2=>16, :ne_3=>26, :ne_4=>-1, :ne_5=>20},
          19 => {:i=>19, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>7, :ne_4=>-1, :ne_5=>17},
          20 => {:i=>20, :type=>0, :res=>0, :ne_0=>8, :ne_1=>-1, :ne_2=>18, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          21 => {:i=>21, :type=>1, :res=>30, :ne_0=>11, :ne_1=>-1, :ne_2=>-1, :ne_3=>27, :ne_4=>23, :ne_5=>13},
          22 => {:i=>22, :type=>1, :res=>30, :ne_0=>28, :ne_1=>24, :ne_2=>14, :ne_3=>12, :ne_4=>-1, :ne_5=>-1},
          23 => {:i=>23, :type=>0, :res=>0, :ne_0=>13, :ne_1=>21, :ne_2=>27, :ne_3=>-1, :ne_4=>16, :ne_5=>6},
          24 => {:i=>24, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>15, :ne_2=>5, :ne_3=>14, :ne_4=>22, :ne_5=>28},
          25 => {:i=>25, :type=>2, :res=>290, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>17, :ne_4=>15, :ne_5=>-1},
          26 => {:i=>26, :type=>2, :res=>290, :ne_0=>18, :ne_1=>16, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          27 => {:i=>27, :type=>0, :res=>0, :ne_0=>21, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>23},
          28 => {:i=>28, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>24, :ne_3=>22, :ne_4=>-1, :ne_5=>-1},
        }
      end

      let(:my_base_indices) { [11] }
      let(:opp_base_indices) { [12] }

      let(:cell_updates) do
        [
          {:i=>0, :res=>52, :my_ants=>0, :opp_ants=>2},
          {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>4},
          {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>2},
          {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>7, :res=>290, :my_ants=>0, :opp_ants=>0},
          {:i=>8, :res=>290, :my_ants=>0, :opp_ants=>0},
          {:i=>9, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>10, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>11, :res=>0, :my_ants=>22, :opp_ants=>0},
          {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>2},
          {:i=>13, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>14, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>17, :res=>40, :my_ants=>0, :opp_ants=>0},
          {:i=>18, :res=>40, :my_ants=>0, :opp_ants=>0},
          {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>21, :res=>7, :my_ants=>11, :opp_ants=>0},
          {:i=>22, :res=>30, :my_ants=>0, :opp_ants=>0},
          {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>25, :res=>290, :my_ants=>0, :opp_ants=>0},
          {:i=>26, :res=>290, :my_ants=>0, :opp_ants=>0},
          {:i=>27, :res=>0, :my_ants=>0, :opp_ants=>0},
          {:i=>28, :res=>0, :my_ants=>0, :opp_ants=>0},
        ]
      end

      it "returns a decision cross fade tail-end of egg gather" do
        is_expected.to eq("LINE 11 21 1; LINE 11 7 1; MESSAGE finishing egg gather and crossfading to mineral gather")
      end
    end

    context "when seed=-2483980375159662600, neearby minerals, but far eggs" do
      let(:cells) do
        {
          0 => {:i=>0, :type=>2, :res=>52, :ne_0=>-1, :ne_1=>1, :ne_2=>3, :ne_3=>-1, :ne_4=>2, :ne_5=>4},
          1 => {:i=>1, :type=>0, :res=>0, :ne_0=>7, :ne_1=>9, :ne_2=>11, :ne_3=>3, :ne_4=>0, :ne_5=>-1},
          2 => {:i=>2, :type=>0, :res=>0, :ne_0=>4, :ne_1=>0, :ne_2=>-1, :ne_3=>8, :ne_4=>10, :ne_5=>12},
          3 => {:i=>3, :type=>0, :res=>0, :ne_0=>1, :ne_1=>11, :ne_2=>13, :ne_3=>15, :ne_4=>-1, :ne_5=>0},
          4 => {:i=>4, :type=>0, :res=>0, :ne_0=>16, :ne_1=>-1, :ne_2=>0, :ne_3=>2, :ne_4=>12, :ne_5=>14},
          5 => {:i=>5, :type=>0, :res=>0, :ne_0=>17, :ne_1=>19, :ne_2=>7, :ne_3=>-1, :ne_4=>16, :ne_5=>24},
          6 => {:i=>6, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>15, :ne_2=>23, :ne_3=>18, :ne_4=>20, :ne_5=>8},
          7 => {:i=>7, :type=>1, :res=>31, :ne_0=>19, :ne_1=>-1, :ne_2=>9, :ne_3=>1, :ne_4=>-1, :ne_5=>5},
          8 => {:i=>8, :type=>1, :res=>31, :ne_0=>2, :ne_1=>-1, :ne_2=>6, :ne_3=>20, :ne_4=>-1, :ne_5=>10},
          9 => {:i=>9, :type=>1, :res=>34, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>11, :ne_4=>1, :ne_5=>7},
          10 => {:i=>10, :type=>1, :res=>34, :ne_0=>12, :ne_1=>2, :ne_2=>8, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          11 => {:i=>11, :type=>0, :res=>0, :ne_0=>9, :ne_1=>-1, :ne_2=>-1, :ne_3=>13, :ne_4=>3, :ne_5=>1},
          12 => {:i=>12, :type=>0, :res=>0, :ne_0=>14, :ne_1=>4, :ne_2=>2, :ne_3=>10, :ne_4=>-1, :ne_5=>-1},
          13 => {:i=>13, :type=>0, :res=>0, :ne_0=>11, :ne_1=>-1, :ne_2=>-1, :ne_3=>21, :ne_4=>15, :ne_5=>3},
          14 => {:i=>14, :type=>0, :res=>0, :ne_0=>22, :ne_1=>16, :ne_2=>4, :ne_3=>12, :ne_4=>-1, :ne_5=>-1},
          15 => {:i=>15, :type=>0, :res=>0, :ne_0=>3, :ne_1=>13, :ne_2=>21, :ne_3=>23, :ne_4=>6, :ne_5=>-1},
          16 => {:i=>16, :type=>0, :res=>0, :ne_0=>24, :ne_1=>5, :ne_2=>-1, :ne_3=>4, :ne_4=>14, :ne_5=>22},
          17 => {:i=>17, :type=>0, :res=>0, :ne_0=>25, :ne_1=>27, :ne_2=>19, :ne_3=>5, :ne_4=>24, :ne_5=>-1},
          18 => {:i=>18, :type=>0, :res=>0, :ne_0=>6, :ne_1=>23, :ne_2=>-1, :ne_3=>26, :ne_4=>28, :ne_5=>20},
          19 => {:i=>19, :type=>0, :res=>0, :ne_0=>27, :ne_1=>-1, :ne_2=>-1, :ne_3=>7, :ne_4=>5, :ne_5=>17},
          20 => {:i=>20, :type=>0, :res=>0, :ne_0=>8, :ne_1=>6, :ne_2=>18, :ne_3=>28, :ne_4=>-1, :ne_5=>-1},
          21 => {:i=>21, :type=>0, :res=>0, :ne_0=>13, :ne_1=>-1, :ne_2=>-1, :ne_3=>29, :ne_4=>23, :ne_5=>15},
          22 => {:i=>22, :type=>0, :res=>0, :ne_0=>30, :ne_1=>24, :ne_2=>16, :ne_3=>14, :ne_4=>-1, :ne_5=>-1},
          23 => {:i=>23, :type=>0, :res=>0, :ne_0=>15, :ne_1=>21, :ne_2=>29, :ne_3=>-1, :ne_4=>18, :ne_5=>6},
          24 => {:i=>24, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>17, :ne_2=>5, :ne_3=>16, :ne_4=>22, :ne_5=>30},
          25 => {:i=>25, :type=>1, :res=>10, :ne_0=>-1, :ne_1=>31, :ne_2=>27, :ne_3=>17, :ne_4=>-1, :ne_5=>38},
          26 => {:i=>26, :type=>1, :res=>10, :ne_0=>18, :ne_1=>-1, :ne_2=>37, :ne_3=>-1, :ne_4=>32, :ne_5=>28},
          27 => {:i=>27, :type=>2, :res=>65, :ne_0=>31, :ne_1=>33, :ne_2=>-1, :ne_3=>19, :ne_4=>17, :ne_5=>25},
          28 => {:i=>28, :type=>2, :res=>65, :ne_0=>20, :ne_1=>18, :ne_2=>26, :ne_3=>32, :ne_4=>34, :ne_5=>-1},
          29 => {:i=>29, :type=>0, :res=>0, :ne_0=>21, :ne_1=>-1, :ne_2=>-1, :ne_3=>35, :ne_4=>-1, :ne_5=>23},
          30 => {:i=>30, :type=>0, :res=>0, :ne_0=>36, :ne_1=>-1, :ne_2=>24, :ne_3=>22, :ne_4=>-1, :ne_5=>-1},
          31 => {:i=>31, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>33, :ne_3=>27, :ne_4=>25, :ne_5=>-1},
          32 => {:i=>32, :type=>0, :res=>0, :ne_0=>28, :ne_1=>26, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>34},
          33 => {:i=>33, :type=>2, :res=>270, :ne_0=>-1, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>27, :ne_5=>31},
          34 => {:i=>34, :type=>2, :res=>270, :ne_0=>-1, :ne_1=>28, :ne_2=>32, :ne_3=>-1, :ne_4=>-1, :ne_5=>-1},
          35 => {:i=>35, :type=>0, :res=>0, :ne_0=>29, :ne_1=>-1, :ne_2=>-1, :ne_3=>-1, :ne_4=>37, :ne_5=>-1},
          36 => {:i=>36, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>38, :ne_2=>-1, :ne_3=>30, :ne_4=>-1, :ne_5=>-1},
          37 => {:i=>37, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>35, :ne_2=>-1, :ne_3=>-1, :ne_4=>-1, :ne_5=>26},
          38 => {:i=>38, :type=>0, :res=>0, :ne_0=>-1, :ne_1=>-1, :ne_2=>25, :ne_3=>-1, :ne_4=>36, :ne_5=>-1},
        }
      end

      let(:my_base_indices) { [32] }
      let(:opp_base_indices) { [31] }

      context "when nearby eggs are gathered and it's time to go afield" do
        let(:cell_updates) do
          [
            {:i=>0, :res=>52, :my_ants=>0, :opp_ants=>0},
            {:i=>1, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>2, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>3, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>4, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>5, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>6, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>7, :res=>31, :my_ants=>0, :opp_ants=>0},
            {:i=>8, :res=>31, :my_ants=>0, :opp_ants=>0},
            {:i=>9, :res=>34, :my_ants=>0, :opp_ants=>0},
            {:i=>10, :res=>34, :my_ants=>0, :opp_ants=>0},
            {:i=>11, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>12, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>13, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>14, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>15, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>16, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>17, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>18, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>19, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>20, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>21, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>22, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>23, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>24, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>25, :res=>0, :my_ants=>0, :opp_ants=>7},
            {:i=>26, :res=>0, :my_ants=>7, :opp_ants=>0},
            {:i=>27, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>28, :res=>65, :my_ants=>0, :opp_ants=>0},
            {:i=>29, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>30, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>31, :res=>0, :my_ants=>0, :opp_ants=>13},
            {:i=>32, :res=>0, :my_ants=>13, :opp_ants=>0},
            {:i=>33, :res=>270, :my_ants=>0, :opp_ants=>0},
            {:i=>34, :res=>270, :my_ants=>0, :opp_ants=>0},
            {:i=>35, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>36, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>37, :res=>0, :my_ants=>0, :opp_ants=>0},
            {:i=>38, :res=>0, :my_ants=>0, :opp_ants=>0},
          ]
        end

        it "returns a decision to go for the nearest egg cluster" do
          is_expected.to eq("BEACON 32 2500; BEACON 28 2500; BEACON 20 2500; BEACON 8 2500; MESSAGE close eggs on 8")
        end
      end
    end
  end
end
