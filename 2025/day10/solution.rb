require 'set'

p1 = 0
p2 = 0

def part1(config, buttons)
  queue = [Set.new]
  visited = Set.new
  least = Float::INFINITY

  while queue.any?
    pressed = queue.shift
    next if visited.include?(pressed)

    visited.add(pressed)

    curr = Array.new(config.length, false)
    pressed.each do |btn_idx|
      buttons[btn_idx].each do |pos|
        curr[pos] = !curr[pos]
      end
    end

    least = pressed.size if curr == config && pressed.size < least

    next if pressed.size >= least - 1

    buttons.each_with_index do |_, btn_idx|
      new_pressed = pressed.dup.add(btn_idx)
      queue << new_pressed unless visited.include?(new_pressed)
    end
  end

  least
end
def part2_greedy(joltage, buttons)
  n = joltage.length
  presses = Array.new(buttons.length, 0)
  
  max_iterations = 100000  # Safety limit
  iterations = 0
  last_reduced_btn = nil  # Track the last reduced button to avoid pressing it immediately
  
  loop do
    iterations += 1
    break if iterations > max_iterations
    
    # Calculate current joltage state
    curr = Array.new(n, 0)
    presses.each_with_index do |count, btn_idx|
      count.times do
        buttons[btn_idx].each { |pos| curr[pos] += 1 }
      end
    end
    
    puts "Iteration #{iterations}: curr=#{curr}, target=#{joltage}, presses=#{presses}"
    
    # Check if we've reached the target
    break if curr == joltage
    
    # Find positions that need adjustment
    diffs = curr.zip(joltage).map { |c, t| t - c }
    
    # If any position is over the target, we need to reduce
    if diffs.any? { |d| d < 0 }
      # Find a button to reduce that affects an over-target position
      over_positions = diffs.each_index.select { |i| diffs[i] < 0 }
      btn_to_reduce = presses.each_index.find do |btn_idx|
        presses[btn_idx] > 0 && (buttons[btn_idx] & over_positions).any?
      end
      puts "  Over target at #{over_positions}, reducing button #{btn_to_reduce}"
      if btn_to_reduce
        presses[btn_to_reduce] -= 1
        last_reduced_btn = btn_to_reduce
      end
    else
      # Find the best button to press
      # Best = affects the most positions that are under-target
      # But skip the button we just reduced to avoid infinite loops
      best_btn = nil
      best_score = -1
      
      buttons.each_with_index do |button, btn_idx|
        # Skip the button we just reduced
        next if btn_idx == last_reduced_btn
        
        score = button.sum { |pos| diffs[pos] > 0 ? diffs[pos] : 0 }
        if score > best_score
          best_score = score
          best_btn = btn_idx
        end
      end
      
      puts "  Best button: #{best_btn} with score #{best_score} (skipping #{last_reduced_btn})"
      break if best_btn.nil? || best_score == 0
      presses[best_btn] += 1
      last_reduced_btn = nil  # Clear the flag after pressing a different button
    end
  end
  
  puts "Final presses: #{presses}, total: #{presses.sum}"
  presses.sum
end

File.readlines('test.txt', chomp: true).each do |line|
  config = line.match(/\[(.+?)\]/)[1].split('').map { |c| c == '#' }
  buttons = line.scan(/\((.+?)\)/).flatten.map do |btn|
    btn.split(',').map(&:to_i)
  end
  joltage = line.match(/\{(.+?)\}/)[1].split(',').map(&:to_i)

  p1 += part1(config, buttons)
  p2 += part2_greedy(joltage, buttons)
end

puts p1
puts p2