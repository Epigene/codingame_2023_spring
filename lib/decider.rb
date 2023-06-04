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
      @eggs_at_start_of_game += data[:res] if data[:type] == EGG

      @graph.ensure_bidirectional_connections!(
        root: i,
        connections: data.slice(:ne_0, :ne_1, :ne_2, :ne_3, :ne_4, :ne_5).values.reject { |n| n.negative? }
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

    egg_cell_indices
    mineral_cell_indices
    path_between_bases # inits path
    contested_cell_indices# inits contested ground
    nearby_cell_indices
  end

  def decide_on(cell_updates:)
    @nearby_minerals = nil
    @best_mining_candidate = nil # resetting memoisation from previous turns
    @best_egg_candidate = nil
    @opportunities = nil
    @my_ants_total = 0
    @opp_ants_total = 0
    @my_ant_cell_indices = []
    @my_cleared_egg_cells = []
    @my_cleared_mineral_cells = []

    cell_update_ms = Benchmark.realtime do
      cell_updates.each do |cell_update|
        next if (cell = cells[cell_update[:i]]).nil?

        cell.merge!(cell_update)
        @my_ants_total += cell_update[:my_ants]
        @opp_ants_total += cell_update[:opp_ants]
        my_ant_cell_indices << cell_update[:i] if cell_update[:my_ants].positive?

        if cell_update[:res].zero?
          if cell[:type] == EGG && egg_cell_indices.include?(cell[:i]) && cell[:my_ants].positive?
            @my_cleared_egg_cells << cell[:i]
          end

          if cell[:type] == CRYSTAL && mineral_cell_indices.include?(cell[:i]) && cell[:my_ants].positive?
            @my_cleared_mineral_cells << cell[:i]
          end

          egg_cell_indices.delete(cell_update[:i])
          mineral_cell_indices.delete(cell_update[:i])
        end
        # debug "#{i}: #{cells[i]}" if cells[i][:res] > 0
      end
    end * 100
    # debug "Cell update took #{cell_update_ms.round}"

    # manual debugging move
    # if true
    #   # BEACON index strength
    #   # LINE i1 i2 strength
    #   return "LINE 9 2 100; MESSAGE Manual try"
    # end

    # @return [Array<Integer>] ======
    if my_ants_total < ant_count_cutoff
      eggs_within_1_of_base = egg_cell_indices.select do |i|
        cells[i][:distance_from_my_base] == 1
      end

      if eggs_within_1_of_base.any?
        cluster_eggs = Set.new
        eggs_within_1_of_base.each do |i|
          next if cells[i][:my_ants].zero?
          cluster_eggs += graph.neighbors_within(i, 1) & egg_cell_indices
        end

        strengths = {}
        eggs_within_1_of_base.each { |i| strengths[i] = 10 }
        strengths[my_base_indices.first] = 10
        cluster_eggs.each { |i| strengths[i] = 20 }

        base = [*eggs_within_1_of_base, my_base_indices.first, *cluster_eggs].uniq.sort.map do |i|
          "BEACON #{i} #{strengths[i]}"
        end.join("; ")

        if eggs_within_1_of_base.one?
          cell = cells[eggs_within_1_of_base.first]
          expected_gathered_eggs = [cell[:res], cell[:my_ants]].min

          if (_will_overmine = expected_gathered_eggs < cell[:my_ants])
            # gotta look for next egg or mineral target

            if expected_gathered_eggs + my_ants_total >= ant_count_cutoff
              # go for minerals
              return "LINE #{my_base_indices.first} #{eggs_within_1_of_base.first} 1; LINE #{my_base_indices.first} #{best_mining_candidate[:i]} 1; MESSAGE finishing egg gather and crossfading to mineral gather"
            else
              # still eggs to gather
              base = "BEACON #{eggs_within_1_of_base.first} 9; LINE #{my_base_indices.first} #{best_egg_candidate(except: [eggs_within_1_of_base.first])} 10"

              if my_ants_total > opp_ants_total
                opportunity_part = opportunities.map do |i|
                  "LINE #{my_base_indices.first} #{i} 10"
                end.join("; ")

                return "#{base}; #{opportunity_part}; MESSAGE opportune crossfading eggs to further egg gather".gsub("; ; ", "; ")
              else
                return "#{base}; MESSAGE crossfading eggs to further egg gather"
              end
            end
          else
            return "#{base}; MESSAGE Egg next to base, yay"
          end
        else
          return "#{base}; MESSAGE Eggs next to base, yay"
        end
      end
    end
    #======================

    # @return [Array<Integer>] ======
    # eggs_within_2_of_base = egg_cell_indices.select do |i|
    #   cells[i][:distance_from_my_base] == 2
    # end

    # if eggs_within_2_of_base.any?
    #   base = eggs_within_2_of_base.map do |i|
    #     "LINE #{my_base_indices.first} #{i} 1"
    #   end

    #   return "#{base}; MESSAGE Eggs almost next to base, yay?"
    # end
    #======================

    # @return [Integer] ===================================
    eggs_being_gathered = egg_cell_indices.find do |i|
      cells[i][:my_ants] > 0 && cells[i][:res] > 0
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
        cell = cells[eggs_being_gathered]
        expected_gathered_eggs = [cell[:res], cell[:my_ants]].min

        if expected_gathered_eggs + my_ants_total >= ant_count_cutoff
          if nearby_minerals.any?
            nearby_portion = nearby_minerals.map do |near_i|
              "BEACON #{near_i} 2000"
            end.join("; ")

            return "#{base}; #{nearby_portion}; MESSAGE Finishing egg gathering and expanding to nearby minerals"
          else
            return "#{base}; LINE #{my_base_indices.first} #{best_mining_candidate[:i]} 1000; MESSAGE Finishing egg gathering and looking for bonus minerals"
          end
        else
          return "#{base}; MESSAGE Continuing egg gathering"
        end
      end
    end
    #======================================================

    # @return [cell hash] ===
    if my_ants_total < ant_count_cutoff
      eggs_closer_to_me = cells.slice(*egg_cell_indices).values.filter_map do |cell|
        next if cell[:distance_from_my_base] > cell[:distance_from_opp_base]
        cell
      end.sort_by do |cell|
        [cell[:distance_from_my_base], -cell[:res]]
      end&.first
      debug "eggs_closer_to_me: #{eggs_closer_to_me}"

      if eggs_closer_to_me && cells[eggs_closer_to_me[:i]][:res] > 0
        # puts "LINE #{my_base_indices.first} #{eggs_closer_to_me[:i]} 1; MESSAGE uncontested eggs on #{eggs_closer_to_me[:i]}"
        return "#{StrengthDistributor.call(from: my_base_indices.first, to: eggs_closer_to_me[:i], ants: my_ants_total, graph: graph)}; MESSAGE close eggs on #{eggs_closer_to_me[:i]}"
      end
    end
    #======================

    if @scuffle_activated || ((my_ants_total >= ant_count_cutoff) && opp_ants_total < my_ants_total && opp_base_indices.one? && cells[opp_base_indices.first][:distance_from_my_base] <= 2)
      # GO FOR THE THROAT!
      @scuffle_activated = true

      return "LINE #{my_base_indices.first} #{best_mining_candidate[:i]} 1; LINE #{my_base_indices.first} #{opp_base_indices.first} 99; MESSAGE *scuffle*"
    end

    if (my_ants_total >= ant_count_cutoff) || egg_cell_indices.none?
      # GO FOR ALL MINERALS!
      base = mineral_cell_indices.map do |i|
        "LINE #{my_base_indices.first} #{i} 100"
      end.join("; ")

      return "#{base}; MESSAGE yeehaw"
    end

    "WAIT; MESSAGE Nothing left to gather!"
  end

  private

  attr_reader :cells, :graph, :number_of_bases, :my_base_indices, :opp_base_indices,
    :eggs_at_start_of_game, :my_ant_cell_indices,
    :my_cleared_egg_cells, :my_cleared_mineral_cells,
    :my_ants_total, :opp_ants_total

  # mineral cells next to just mined out eggs
  def opportunities
    return @opportunities if @opportunities

    @opportunities = Set.new

    my_cleared_egg_cells.each do |i|
      @opportunities += graph.neighbors_within(i, 1)
    end

    my_cleared_mineral_cells.each do |i|
      @opportunities += graph.neighbors_within(i, 1)
    end

    @opportunities &= mineral_cell_indices
  end

  def opportunities_and_ongoing
    opportunities + cells.slice(*mineral_cell_indices).filter_map do |k, c|
      next unless c[:my_ants].positive?
      c[:i]
    end
  end

  # @return [Integer, nil]
  def best_egg_candidate(except: [])
    eggs_closer_to_me = cells.slice(*egg_cell_indices - except).values.filter_map do |cell|
      next if cell[:distance_from_my_base] >= cell[:distance_from_opp_base]
      cell
    end.sort_by do |cell|
      [cell[:distance_from_my_base], -cell[:res]]
    end&.first

    eggs_closer_to_me&.[](:i)
  end

  # @return [Hash cell]
  def best_mining_candidate
    return @best_mining_candidate if @best_mining_candidate

    @best_mining_candidate =
      if nearby_minerals.any?
        debug "Yay, found nearby minerals!"
        cells[nearby_minerals.first]
      else
        cells.slice(*mineral_cell_indices).values.min_by do |cell|
          [cell[:distance_from_my_base], -cell[:res]]
        end
      end
  end

  def nearby_minerals
    return @nearby_minerals if @nearby_minerals
    mem = Set.new
    my_ant_cell_indices.each do |ant_cell_i|
      mem |= graph.neighbors_within(ant_cell_i, 1)
    end
    @nearby_minerals = mem & mineral_cell_indices
  end

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
    return @path_between_bases if defined?(@path_between_bases)

    debug "Path between bases: #{my_base_indices.first} and #{opp_base_indices.first}"
    @path_between_bases = graph.dijkstra_shortest_path(my_base_indices.first, opp_base_indices.first)
    debug "  #{@path_between_bases}"
    @path_between_bases
  end

  # @return [Integer]
  def cells_between_bases
    @cells_between_bases ||= path_between_bases[1..-2].size
  end

  def contested_cell_indices
    return @contested_cell_indices if defined?(@contested_cell_indices)

    @contested_cell_indices ||=
      if cells_between_bases > 6
        debug "Bases too far apart, using simplified contested ground"
        path_between_bases[1..-2].to_set
      else
        graph.neighbors_within(my_base_indices.first, cells_between_bases) &
          graph.neighbors_within(opp_base_indices.first, cells_between_bases)
      end

    debug "Contested cells are: #{@contested_cell_indices}"

    @contested_cell_indices
  end

  def nearby_cell_indices
    return @nearby_cell_indices if defined?(@nearby_cell_indices)

    max_distance_to_check = [cells_between_bases, 6].min

    @nearby_cell_indices = graph.neighbors_within(my_base_indices.first, max_distance_to_check)
    debug "Nearby cells are: #{@nearby_cell_indices}"
    @nearby_cell_indices
  end

  def my_half_of_eggs
    @my_half_of_eggs ||= eggs_at_start_of_game / 2
  end

  # When I have half of the max ants possible
  def ant_count_cutoff
    STARTING_ANT_COUNT + my_half_of_eggs
  end
end
