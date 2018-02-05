def cost(vector)
  sum = 0
  vector.each do |v|
    sum += v ** 2
  end
  return sum
end

def rand_in_bounds(min, max)
  return rand(min.to_f...max)
end


def take_step(min, max, current, step_size)
  position = []
  current.size.times do |i|
    min = [min, current[i]-step_size].max
    max = [max, current[i]+step_size].min
    position[i] = rand_in_bounds(min, max)
  end
  return position
end

def large_step_size(i, step_size, s_factor, l_factor, iter_mult)
  return step_size * l_factor if(i % iter_mult == 0)
  return step_size * s_factor
end


def search(num_times,problem_size, min, max, init_step_factor, s_factor, l_factor, iter_mult, max_no_impr)
  step_size = (max - min) * init_step_factor
  current, count = {}, 0
  current = [rand_in_bounds(min, max)] * problem_size
  puts "Searching: #{current}"

  num_times.times do |i|
    big_stepsize = large_step_size(i, step_size, s_factor, l_factor, iter_mult)
    step = take_step(min, max, current, step_size)
    big_step = take_step(min, max,current,big_stepsize)

    if cost(big_step) <= cost(current)
      step_size = big_stepsize
      current = big_step
      count = 0
    elsif cost(step) <= cost(current)
      current = step
      count = 0
    else
      count += 1
      if count >= max_no_impr
        count = 0
        step_size /= s_factor
      end
    end
    puts " > iteration #{(i+1)}, best=#{cost(current)}"
  end
  return current
end

if __FILE__ == $0
  # problem configuration
  problem_size = 2
  min = -5
  max = 5
  minmax = [[min, max]] * problem_size
  # algorithm configuration
  num_times = 1000
  init_step_factor = 0.05
  s_factor = 1.3
  l_factor = 3.0
  iter_mult = 10
  max_no_impr = 30
  # execute the algorithm
  best = search(num_times,problem_size, min, max, init_step_factor, s_factor, l_factor, iter_mult, max_no_impr)
  puts "Done. Best Solution: c=#{cost(best)}, v=#{best.inspect}"
end
