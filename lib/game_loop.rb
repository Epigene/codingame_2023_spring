loop do
  # debug "New turn"

  cell_updates = []

  debug "CELL UPDATES:"
  number_of_cells.times do |i|
    # res: the current amount of eggs/crystals on this cell
    # my_ants: the amount of your ants on this cell
    # opp_ants: the amount of opponent ants on this cell
    res, my_ants, opp_ants = gets.split(" ").collect { |x| x.to_i }

    update = {
      i: i,
      res: res,
      my_ants: my_ants,
      opp_ants: opp_ants
    }

    cell_updates << update
    debug "#{update},"
  end

  puts decider.decide_on(cell_updates: cell_updates)
end
