require "set"
require "benchmark"

STDOUT.sync = true # DO NOT REMOVE

CRYSTAL = 2
EGG = 1

def debug(message)
  STDERR.puts message
end
