require 'set'

points = File.readlines('input.txt', chomp: true).map { |l| l.split(',').map(&:to_i) }
n = points.size

dists = []
points.each_with_index do |(x1,y1,z1), i|
  points.each_with_index do |(x2,y2,z2), j|
    next if i >= j 
    d = (x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2
    dists << [d, i, j]
  end
end
dists.sort_by!(&:first)

def merge_components(comps, i, j)
  comp_i = comps.find { |c| c.include?(i) }
  comp_j = comps.find { |c| c.include?(j) }
  
  return false if comp_i == comp_j
  
  if comp_i.size < comp_j.size
    comp_i, comp_j = comp_j, comp_i
  end
  
  comp_i.merge(comp_j)
  comps.delete(comp_j)
  true  
end

components = n.times.map { |i| Set[i] }
edges_added = 0
last_edge = nil
p1 = 0

dists.each_with_index do |(_, i, j), edge_idx|
  if merge_components(components, i, j)
    edges_added += 1
    last_edge = [i, j]
    
    break if edges_added == n - 1
  end
  
  if edge_idx == 999
    sizes = components.map(&:size).sort
    p1 = sizes.last(3).inject(:*)
  end
end

i, j = last_edge
p2 = points[i][0] * points[j][0]

puts p1
puts p2
