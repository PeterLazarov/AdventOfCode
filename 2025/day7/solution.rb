p1 = 0
paths = Hash.new(0)

File.readlines('input.txt', chomp: true).each_with_index do |line, idx|
  if idx == 0
    start_col = line.index('S')
    paths[start_col] = 1
  else
    new_paths = Hash.new(0)

    line.chars.each_with_index do |char, col|
      next unless paths[col] > 0

      if char == '^'
        p1 += 1
        new_paths[col - 1] += paths[col]
        new_paths[col + 1] += paths[col]
      else
        new_paths[col] += paths[col]
      end
    end

    paths = new_paths
  end
end

p2 = paths.values.sum
puts p1
puts p2
