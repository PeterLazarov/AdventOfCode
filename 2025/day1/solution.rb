pos = 50
p1 = 0
p2 = 0

File.readlines('input.txt', chomp: true).each do |line|
  direction = line[0]
  amount = line[1..].to_i

  amount.times do
    pos = direction == 'L' ? (pos - 1) % 100 : (pos + 1) % 100
    p2 += 1 if pos.zero?
  end

  p1 += 1 if pos.zero?
end

puts p1
puts p2
