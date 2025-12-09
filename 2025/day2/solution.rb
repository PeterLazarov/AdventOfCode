file_body = File.new('input.txt', 'r')

line = file_body.gets

ranges = line.split(',').map do |range|
  range.split('-').map(&:to_i)
end

p1 = 0
p2 = 0
ranges.each do |range|
  (range[0]..range[1]).each do |num|
    p1 += num if num.to_s.match(/^(\d+)\1$/)
    p2 += num if num.to_s.match(/^(\d+)(?:\1)+$/)
  end
end
puts p1
puts p2
file_body.close
