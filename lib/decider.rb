class Decider
  def initialize(cells:, number_of_bases:, my_base_indices:, opp_base_indices:)
    @cells = cells
    @number_of_bases = number_of_bases
    @my_base_indices = my_base_indices
    @opp_base_indices = opp_base_indices
    # debug @number_of_bases
    # debug @my_base_indices
    # debug @opp_base_indices

    @graph = Graph.new

    @eggs_at_start_of_game = 0

    @cells.each do |i, data|
      @eggs_at_start_of_game += data[:resources] if data[:type] == EGG

      @graph.ensure_bidirectional_connections!(
        root: i,
        connections: data.slice(:neigh_0, :neigh_1, :neigh_2, :neigh_3, :neigh_4, :neigh_5).values.reject { |n| n.negative? }
      )
      # debug "Node #{i} graph: #{graph[i]}"
    end

    @cells.keys.each do |i|
      path = @graph.dijkstra_shortest_path(i, @my_base_indices.first)

      @cells[i][:distance_from_my_base] =
        if path
          path.size - 1
        else
          # as in the cell is base itself.
          0
        end

      path = @graph.dijkstra_shortest_path(i, @opp_base_indices.first)

      @cells[i][:distance_from_opp_base] =
        if path
          path.size - 1
        else
          # as in the cell is base itself.
          0
        end
    end
  end

  def decide_on(cell_updates:)
    my_ants_total = 0

    cell_updates.each do |cell_update|
      next if cells[cell_update[:i]].nil?

      cells[cell_update[:i]].merge!(cell_update)
      my_ants_total += cell_update[:my_ants]

      if cell_update[:resources].zero?
        egg_cell_indices.delete(cell_update[:i])
        mineral_cell_indices.delete(cell_update[:i])
      end
      # debug "#{i}: #{cells[i]}" if cells[i][:resources] > 0
    end

    # manual debugging move
    # if true
    #   puts "BEACON #{my_base_indices.first} 2; BEACON 2 8; MESSAGE Manual try"
    #   # BEACON index strength
    #   # LINE i1 i2 strength
    #   next
    # end

    # @return [Integer] ==
    eggs_being_gathered = egg_cell_indices.find do |i|
      cells[i][:my_ants] > 0 && cells[i][:resources] > 0
    end
    debug "eggs_being_gathered: #{eggs_being_gathered}"

    if eggs_being_gathered
      eggs_next_to_gathering = graph.neighbors_within(eggs_being_gathered, 1) & egg_cell_indices
      base = StrengthDistributor.call(from: my_base_indices.first, to: eggs_being_gathered, ants: my_ants_total, graph: graph)

      if eggs_next_to_gathering.any?
        base_strength = base.split("; ").first.split(" ")[2]
        expansion_portion = eggs_next_to_gathering.map { |p| "BEACON #{p} #{base_strength}" }.join("; ")

        return "#{base}; #{expansion_portion}; MESSAGE Expanding on egg gathering"
      else
        return "#{base}; MESSAGE Continuing egg gathering"
      end
    end
    #======================

    # @return [Cell hash] =
    eggs_in_contested_ground = cells.slice(*(contested_cell_indices & egg_cell_indices)).values.max_by do |cell|
      cell[:resources]
    end
    debug "eggs_in_contested_ground: #{eggs_in_contested_ground}"

    if eggs_in_contested_ground && cells[eggs_in_contested_ground[:i]][:resources] > 0
      # puts "LINE #{my_base_indices.first} #{eggs_in_contested_ground[:i]} 1; MESSAGE Jumping to collect contested eggs on #{eggs_in_contested_ground[:i]}"
      return "#{StrengthDistributor.call(from: my_base_indices.first, to: eggs_in_contested_ground[:i], ants: my_ants_total, graph: graph)}; MESSAGE Jumping to collect contested eggs on #{eggs_in_contested_ground[:i]}"
    end
    #======================

    # @return [cell hash] ===
    eggs_closer_to_me = cells.slice(*egg_cell_indices).values.filter_map do |cell|
      next if cell[:distance_from_my_base] >= cell[:distance_from_opp_base]
      cell
    end.sort_by do |cell|
      [cell[:distance_from_my_base], -cell[:resources]]
    end&.first
    debug "eggs_closer_to_me: #{eggs_closer_to_me}"

    if eggs_closer_to_me && cells[eggs_closer_to_me[:i]][:resources] > 0
      # puts "LINE #{my_base_indices.first} #{eggs_closer_to_me[:i]} 1; MESSAGE uncontested eggs on #{eggs_closer_to_me[:i]}"
      return "#{StrengthDistributor.call(from: my_base_indices.first, to: eggs_closer_to_me[:i], ants: my_ants_total, graph: graph)}; MESSAGE close eggs on #{eggs_closer_to_me[:i]}"
    end
    #======================

    # @return [Integer] ===
    cell_being_harvested = mineral_cell_indices.find do |i|
      cells[i][:my_ants] > 0 && cells[i][:resources] > 0
    end
    debug "cell_being_harvested: #{cell_being_harvested}"

    if cell_being_harvested
      # puts "LINE #{my_base_indices.first} #{cell_being_harvested} 1; MESSAGE Continuing harvesting of #{cell_being_harvested}"
      return "#{StrengthDistributor.call(from: my_base_indices.first, to: cell_being_harvested, ants: my_ants_total, graph: graph)}; MESSAGE Continuing harvesting of #{cell_being_harvested}"
    end
    #======================

    # @return [Cell hash]
    best_mining_candidate = cells.slice(*mineral_cell_indices).values.min_by do |cell|
      [cell[:distance_from_my_base], -cell[:resources]]
    end
    debug "Best mining candidate: #{best_mining_candidate}"

    if best_mining_candidate && cells[best_mining_candidate[:i]][:resources] > 0
      # puts "LINE #{my_base_indices.first} #{best_mining_candidate[:i]} 1; MESSAGE Lining up towards #{best_mining_candidate[:i]}"
      return "#{StrengthDistributor.call(from: my_base_indices.first, to: best_mining_candidate[:i], ants: my_ants_total, graph: graph)}; MESSAGE Lining up towards #{best_mining_candidate[:i]}"
    end
    #======================

    # LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
    "WAIT; MESSAGE Nothing left to gather!"
  end

  private

  attr_reader :cells, :graph, :number_of_bases, :my_base_indices, :opp_base_indices, :eggs_at_start_of_game

  def egg_cell_indices
    @egg_cell_indices ||= cells.each_with_object(Set.new) do |(i, cell), mem|
      next unless cell[:type] == EGG
      mem << i
    end
  end

  def mineral_cell_indices
    @mineral_cell_indices ||= cells.each_with_object(Set.new) do |(i, cell), mem|
      next unless cell[:type] == CRYSTAL
      mem << i
    end
  end

  def path_between_bases
    debug "Path between bases: #{my_base_indices.first} and #{opp_base_indices.first}"
    @path_between_bases ||= graph.dijkstra_shortest_path(my_base_indices.first, opp_base_indices.first)
    debug "  #{@path_between_bases}"
    @path_between_bases
  end

  def cells_between_bases
    @cells_between_bases ||= path_between_bases[1..-2].size
  end

  def contested_cell_indices
    @contested_cell_indices ||=
      graph.neighbors_within(my_base_indices.first, cells_between_bases) &
      graph.neighbors_within(opp_base_indices.first, cells_between_bases)

    debug "Contested cells are: #{@contested_cell_indices}"

    @contested_cell_indices
  end

  def nearby_cell_indices
    @nearby_cell_indices ||= graph.neighbors_within(my_base_indices.first, cells_between_bases)
    debug "Nearby cells are: #{@nearby_cell_indices}"
    @nearby_cell_indices
  end

  def my_half_of_eggs
    @my_half_of_eggs ||= eggs_at_start_of_game / 2
  end
end
