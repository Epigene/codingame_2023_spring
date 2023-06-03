loop do
  # debug "New turn"
  number_of_cells.times do |i|
    # resources: the current amount of eggs/crystals on this cell
    # my_ants: the amount of your ants on this cell
    # opp_ants: the amount of opponent ants on this cell
    resources, my_ants, opp_ants = gets.split(" ").collect { |x| x.to_i }
    cells[i][:resources] = resources
    cells[i][:my_ants] = my_ants
    cells[i][:opp_ants] = opp_ants
    # debug "#{i}: #{cells[i]}" if cells[i][:resources] > 0
  end

  # manual debugging move
  # if true
  #   puts "LINE #{my_base_indices.first} 5 1; MESSAGE Manual try"
  #   next
  # end

  # @return [Integer] ==
  eggs_being_gathered = egg_cell_indices.find do |i|
    cells[i][:my_ants] > 0 && cells[i][:resources] > 0
  end
  debug "eggs_being_gathered: #{eggs_being_gathered}"

  if eggs_being_gathered
    puts "LINE #{my_base_indices.first} #{eggs_being_gathered} 1; MESSAGE Continuing egg gathering"
    next
  end
  #======================

  # @return [Cell hash] =
  eggs_in_contested_ground = cells.slice(*(contested_cell_indices & egg_cell_indices)).values.max_by do |cell|
    cell[:resources]
  end
  debug "eggs_in_contested_ground: #{eggs_in_contested_ground}"

  if eggs_in_contested_ground && cells[eggs_in_contested_ground[:i]][:resources] > 0
    puts "LINE #{my_base_indices.first} #{eggs_in_contested_ground[:i]} 1; MESSAGE Jumping to collect contested eggs on #{eggs_in_contested_ground[:i]}"
    next
  end
  #======================
  eggs_nearby = cells.slice(*(nearby_cell_indices & egg_cell_indices)).values.max_by do |cell|
    cell[:resources]
  end
  debug "eggs_nearby: #{eggs_nearby}"

  if eggs_nearby && cells[eggs_nearby[:i]][:resources] > 0
    puts "LINE #{my_base_indices.first} #{eggs_nearby[:i]} 1; MESSAGE uncontested eggs on #{eggs_nearby[:i]}"
    next
  end

  # @return [Integer] ===
  cell_being_harvested = mineral_cell_indices.find do |i|
    cells[i][:my_ants] > 0 && cells[i][:resources] > 0
  end
  debug "cell_being_harvested: #{cell_being_harvested}"

  if cell_being_harvested
    puts "LINE #{my_base_indices.first} #{cell_being_harvested} 1; MESSAGE Continuing harvesting of #{cell_being_harvested}"
    next
  end
  #======================

  # @return [Cell hash]
  best_mining_candidate = cells.slice(*mineral_cell_indices).values.max_by do |cell|
    cell[:resources]
  end
  debug "Best mining candidate: #{best_mining_candidate}"

  if best_mining_candidate && cells[best_mining_candidate[:i]][:resources] > 0
    puts "LINE #{my_base_indices.first} #{best_mining_candidate[:i]} 1; MESSAGE Lining up towards #{best_mining_candidate[:i]}"
    next
  end
  #======================

  # LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
  puts "WAIT; MESSAGE Nothing left to gather!"
end
