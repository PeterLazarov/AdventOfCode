points = File.readlines('test.txt', chomp: true).map { |l| l.split(',').map(&:to_i) }
n = points.size

areas = []
points.each_with_index do |(x1,y1), i|
  points.each_with_index do |(x2,y2), j|
    next if i >= j
    width = x1 - x2 + 1
    height = y1 - y2 + 1
    a = width * height
    areas << a
  end
end
areas.sort_by! { |a| -a }

p1 = areas.first

puts p1

sorted = points.sort_by { |p| p[0] }

fx = sorted.first[0]
lx = sorted.last[0]

(f...l).each do |x|


  puts p.inspect
end


