rolls_data = File.read('input.txt').split("\n")

def part_one(rolls)
  sum = 0
  rolls.each_with_index do |roll, x|
    roll.chars.each_with_index do |c, y|
      next unless c == '@'

      nbr = 0
      (-1..1).each do |x_mod|
        (-1..1).each do |y_mod|
          y_n = y + y_mod
          x_n = x + x_mod

          nbr += 1 if x_n >= 0 && x_n < rolls.length && y_n >= 0 && y_n < roll.length && rolls[x_n][y_n] == '@'
        end
      end

      sum += 1 if nbr < 5
    end
  end
  sum
end

def part_two(rolls)
  sum = 0
  loop do
    changed = false
    rolls.each_with_index do |roll, x|
      roll.chars.each_with_index do |c, y|
        next unless c == '@'

        nbr = 0
        (-1..1).each do |x_mod|
          (-1..1).each do |y_mod|
            y_n = y + y_mod
            x_n = x + x_mod

            nbr += 1 if x_n >= 0 && x_n < rolls.length && y_n >= 0 && y_n < roll.length && rolls[x_n][y_n] == '@'
          end
        end

        next unless nbr < 5

        sum += 1
        rolls[x][y] = '.'
        changed = true
      end
    end
    break unless changed
  end
  sum
end

p1 = part_one(rolls_data)
p2 = part_two(rolls_data)
puts p1
puts p2
