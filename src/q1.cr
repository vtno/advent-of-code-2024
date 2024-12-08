require "benchmark"
require "wait_group"

def parse_input(file_path)  
  lines = File.read_lines(file_path)
  
  first = Array(Int32).new(lines.size, 0)
  second = Array(Int32).new(lines.size, 0)
  
  lines.each_with_index do |line, i|
    row = line.split(" ")
    first[i] = row[0].to_i
    second[i] = row[-1].to_i
  end

  {first, second}
end

def solve
  file_path = Path.new(__DIR__, "q1.txt")
  first, second = parse_input(file_path)
  
  wg = WaitGroup.new(2)
  spawn do
    first.sort!
  ensure
    wg.done
  end

  spawn do
    second.sort!
  ensure
    wg.done
  end

  wg.wait

  sum = 0
  first.each_with_index do |f, i|
    sum += (f - second[i]).abs
  end

  puts sum
end

def solve_2
  file_path = Path.new(__DIR__, "q1.txt")
  first, second = parse_input(file_path)
  puts first.sum { |f| f * second.count(f) }
end

Benchmark.bm do |x|
  x.report("solve:") { solve }
  x.report("solve_2:") { solve_2 }
end

# Surface Go 2 2017 Intel Pentium Gold 4415Y 1.6Ghz
# PS C:\Users\tinot\Workspace\advent-of-code-2024> .\task_runner.ps1 q1 -Mode run
#                user     system      total        real
# solve:   1938424
#   0.015625   0.000000   0.015625 (  0.001673)
# solve_2: 22014209
#   0.000000   0.000000   0.000000 (  0.002430)