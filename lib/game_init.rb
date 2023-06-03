# == INIT ==
number_of_cells = gets.to_i # amount of hexagonal cells in this map
cells = {}
graph = Graph.new

number_of_cells.times do |i|
  # type: 0 for empty, 1 for eggs, 2 for crystal
  # initial_resources: the initial amount of eggs/crystals on this cell
  # neigh_0: the index of the neighbouring cell for each direction
  type, resources, neigh_0, neigh_1, neigh_2, neigh_3, neigh_4, neigh_5 = gets.split(" ").map(&:to_i)

  cells[i] = {
    i: i,
    type: type, # 1 egg, 2 crystal, 0 empty/base
    resources: resources,
    neigh_0: neigh_0, neigh_1: neigh_1, neigh_2: neigh_2, neigh_3: neigh_3, neigh_4: neigh_4, neigh_5: neigh_5
  }

  graph.ensure_bidirectional_connections!(
    root: i,
    connections: [neigh_0, neigh_1, neigh_2, neigh_3, neigh_4, neigh_5].reject { |n| n.negative? }
  )

  # debug "Node #{i} graph: #{graph[i]}"
end

egg_cell_indices = cells.each_with_object(Set.new) do |(i, cell), mem|
  next unless cell[:type] == EGG

  mem << i
end

mineral_cell_indices = cells.each_with_object(Set.new) do |(i, cell), mem|
  next unless cell[:type] == CRYSTAL

  mem << i
end

number_of_bases = gets.to_i

my_base_indices = gets.split(" ").map do |i|
  cells[i.to_i][:my_base] = true
  i.to_i
end
opp_base_indices = gets.split(" ").map do |i|
  cells[i.to_i][:opp_base] = true
  i.to_i
end
# cells.each_pair do |k, v|
#   STDERR.puts "#{k}: #{v}"
# end
# debug "=========="
# cells_with_minerals.each_pair do |k, v|
#   debug "#{k}: #{v}"
# end

debug "Path between bases: #{my_base_indices.first} and #{opp_base_indices.first}"
path_between_bases = graph.dijkstra_shortest_path(my_base_indices.first, opp_base_indices.first)
debug "  #{path_between_bases.to_s}"

cells_between_bases = path_between_bases[1..-2].size

contested_cell_indices = graph.neighbors_within(my_base_indices.first, cells_between_bases) & graph.neighbors_within(opp_base_indices.first, cells_between_bases)
debug "Contested cells are: #{contested_cell_indices}"

nearby_cell_indices = graph.neighbors_within(my_base_indices.first, cells_between_bases)
debug "Nearby cells are: #{contested_cell_indices}"
# == INIT ==
