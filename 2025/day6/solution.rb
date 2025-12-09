tasks1 = []
tasks2 = []

lines = File.readlines('input.txt', chomp: true)

columns = lines.map(&:length).max

task_idx = 0

Task = Struct.new(:numbers, :action)
columns.times do |col_idx|
  num_found = false
  num = ''
  lines.each_with_index do |line, row_idx|
    char = line[col_idx] || ' '

    num_found ||= char =~ /\d/

    tasks1[task_idx] ||= Task.new([], '')
    tasks2[task_idx] ||= Task.new([], '')
    if row_idx == lines.length - 1 && char != ' '
      tasks1[task_idx].action = char
      tasks2[task_idx].action = char
    else
      tasks1[task_idx].numbers[row_idx] ||= ''
      tasks1[task_idx].numbers[row_idx] << char

      num << char
    end
  end

  tasks2[task_idx].numbers << num if num_found
  task_idx += 1 unless num_found
end

def solve_tasks(tasks)
  tasks.sum do |task|
    numbers = task.numbers.map { |n| n.to_i unless n.strip.empty? }.compact
    case task.action.strip
    when '+' then numbers.sum
    when '*' then numbers.reduce(1, :*)
    else 0
    end
  end
end

puts solve_tasks(tasks1)
puts solve_tasks(tasks2)
