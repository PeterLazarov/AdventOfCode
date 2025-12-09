def max_number_from_combinations(chars, length)
  return 0 if chars.length < length

  start_idx = 0
  length.times.map do |pos|
    end_idx = chars.length - length + pos
    best_idx = (start_idx..end_idx).max_by { |i| chars[i] }
    start_idx = best_idx + 1
    chars[best_idx]
  end.join.to_i
end

p1 = 0
p2 = 0

File.readlines('input.txt', chomp: true).each do |line|
  p1 += max_number_from_combinations(line.chars, 2)
  p2 += max_number_from_combinations(line.chars, 12)
end

puts p1
puts p2
