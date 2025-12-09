p1 = 0
p2 = 0

ranges, ids = File.read('input.txt').split("\n\n")
ranges = ranges.split("\n").map do |range|
  range.split('-').map(&:to_i)
end.sort
ids = ids.split("\n").map(&:to_i)

ids.each do |id|
  ranges.each do |range|
    if id.between?(range[0], range[1])
      p1 += 1
      break
    end
  end
end

prev_end = -1
ranges.each do |s, e|
  s = prev_end + 1 if s <= prev_end
  p2 += e - s + 1 if s <= e
  prev_end = [prev_end, e].max
end

puts p1
puts p2
