# == INIT ==
number_of_cells = gets.to_i # amount of hexagonal cells in this map
cells = {}

number_of_cells.times do |i|
  # type: 0 for empty, 1 for eggs, 2 for crystal
  # initial_res: the initial amount of eggs/crystals on this cell
  # ne_0: the index of the neighbouring cell for each direction
  type, res, ne_0, ne_1, ne_2, ne_3, ne_4, ne_5 = gets.split(" ").map(&:to_i)

  cells[i] = {
    i: i,
    type: type, # 1 egg, 2 crystal, 0 empty/base
    res: res,
    ne_0: ne_0, ne_1: ne_1, ne_2: ne_2, ne_3: ne_3, ne_4: ne_4, ne_5: ne_5
  }
end

cells.each_pair do |k, v|
  # next if k < 32
  debug "#{k} => #{v},"
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

decider = Decider.new(
  cells: cells,
  number_of_bases: number_of_bases,
  my_base_indices: my_base_indices,
  opp_base_indices: opp_base_indices
)
# == INIT ==
