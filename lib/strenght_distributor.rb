class StrengthDistributor
  # @param path [Array<Object>] directional array of node IDs
  # @param ants [Integer] how many to distribute
  def self.call(from:, to:, ants:, graph:)
    new(from:, to:, ants: ants, graph: graph).call
  end

  def initialize(from:, to:, ants:, graph:)
    @from = from
    @to = to
    @ants = ants
    @graph = graph
  end

  # @return [String] an expansion of LINE command into individual, more efficient
  # BEACON calls.
  def call
    # all ants == 10000
    # 1 ant = 10000/ants
    percent_per_ant = 10000/ants.to_f

    # minimum = (ants.to_f / path_lenght.to_f * 100).round
    minimum_ants = ants / path_lenght
    ants_remaining = ants

    path[0..-2].map do |node|
      ants_remaining -= minimum_ants
      "BEACON #{node} #{(minimum_ants*percent_per_ant).round}"
    end.join("; ") + "; BEACON #{path.last} #{(ants_remaining*percent_per_ant).round}"
  end

  private

  attr_reader :from, :to, :ants, :graph

  def path
    @path ||= graph.dijkstra_shortest_path(from, to)
  end

  def path_lenght
    @path_lenght ||= path.size
  end
end
