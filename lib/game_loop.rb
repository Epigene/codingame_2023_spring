loop do
  debug "New turn"
  number_of_cells.times do |i|
    # resources: the current amount of eggs/crystals on this cell
    # my_ants: the amount of your ants on this cell
    # opp_ants: the amount of opponent ants on this cell
    resources, my_ants, opp_ants = gets.split(" ").collect { |x| x.to_i }
    cells[i][:resources] = resources
    cells[i][:my_ants] = my_ants
    cells[i][:opp_ants] = opp_ants
    debug "#{i}: #{cells[i]}" if cells[i][:resources] > 0
  end

  cell_being_harvested = cells.find do |i, cell|
    cell[:type] == CRYSTAL && cell[:my_ants] > 0 && cell[:resources] > 0
  end&.first

  debug "cell_being_harvested: #{cell_being_harvested}"

  if cell_being_harvested
    puts "LINE #{my_base_indices.first} #{cell_being_harvested} 1; MESSAGE Continuing harvesting of #{cell_being_harvested}"
    next
  end

  best_mining_candidate = cells.slice(*cells_with_minerals.keys).values.sort_by do |cell|
    cell[:resources]
  end.last

  debug "Best candidate: #{best_mining_candidate}"

  if best_mining_candidate && cells[best_mining_candidate[:i]][:resources] > 0
    puts "LINE #{my_base_indices.first} #{best_mining_candidate[:i]} 1; MESSAGE Lining up towards #{best_mining_candidate[:i]}"
    next
  end

  # LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
  puts "WAIT; MESSAGE Nothing left to gather!"
end
