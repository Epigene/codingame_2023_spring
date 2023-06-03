# frozen_string_literal: true

# rspec spec/graph_spec.rb
RSpec.describe Graph, instance_name: :graph do
  let(:graph) { described_class.new }

  it "can be initialized without arguments" do
    expect(described_class.new).to be_a(described_class)
  end

  describe "#ensure_bidirectional_connection!(node1, node2)" do
    subject(:ensure_bidirectional_connection!) { graph.ensure_bidirectional_connection!("A", "B") }

    it "ensures the graph structure has the two nodes mentioned and that they are connected" do
      ensure_bidirectional_connection!

      expect(graph["A"]).to eq(neighbors: ["B"].to_set)
      expect(graph["B"]).to eq(neighbors: ["A"].to_set)
    end
  end

  describe "#ensure_bidirectional_connections!(root:, connections: [])" do
    subject(:ensure_bidirectional_connections!) do
      graph.ensure_bidirectional_connections!(root: root, connections: connections)
    end

    let(:root) { "A" }

    context "when no connections are mentioned" do
      let(:connections) { [] }

      it "ensures the root node without any neighbors" do
        ensure_bidirectional_connections!

        expect(graph[root]).to eq(neighbors: Set.new)
      end
    end

    context "when some connections are mentioned" do
      let(:connections) { ["B", "C", 2] }

      it "ensures the root node and appropriate neighbor nodes" do
        ensure_bidirectional_connections!

        expect(graph[root]).to eq(neighbors: ["B", "C", 2].to_set)
        expect(graph["B"]).to eq(neighbors: ["A"].to_set)
      end
    end
  end

  describe "#dijkstra_shortest_path(root, destination)" do
    subject(:dijkstra_shortest_path) { graph.dijkstra_shortest_path(root, destination) }

    context "when the nodes are disjointed and there is no path between them" do
      let(:root) { 1 }
      let(:destination) { 2 }

      before do
        graph.ensure_bidirectional_connection!("A", 1)
        graph.ensure_bidirectional_connection!("B", 2)
      end

      it { is_expected.to be_nil }
    end

    context "when the nodes are connected so there is a shortest path" do
      # 1--b--2
      #  \   /
      #   x-y
      #   \
      #    z
      let(:root) { 1 }
      let(:destination) { 2 }

      before do
        graph.ensure_bidirectional_connections!(root: 1, connections: ["b", "x"])
        graph.ensure_bidirectional_connections!(root: "b", connections: [1, 2])
        graph.ensure_bidirectional_connections!(root: 2, connections: ["b", "y"])
        graph.ensure_bidirectional_connections!(root: "x", connections: [1, "y", "z"])
        graph.ensure_bidirectional_connections!(root: "y", connections: ["x", 2])
        graph.ensure_bidirectional_connections!(root: "z", connections: ["x"])
      end

      it "finds shortest paths" do
        expect(graph.dijkstra_shortest_path(1, "b")).to eq([1, "b"])
        expect(graph.dijkstra_shortest_path(1, 2)).to eq([1, "b", 2])
        expect(graph.dijkstra_shortest_path(1, "z")).to eq([1, "x", "z"])
        expect(graph.dijkstra_shortest_path("z", "b")).to eq(["z", "x", 1, "b"])
      end
    end
  end
end
