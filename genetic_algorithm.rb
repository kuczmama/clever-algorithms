def fitness(bitstring)
  bitstring.sum
end

def best_from_population(pop)
  pop.max{|x,y| fitness(x) <=> fitness(y)}
end

def binary_tournament(pop)
  best_from_population(pop.sample(2))
end

def point_mutation(bitstring, rate=1.0/bitstring.size)
  bitstring.map{|x| (rand() > 0.98) ? (x ? 1 : 0): x}
end

def crossover(parent1, parent2, rate)
  return parent1 if rand()>=rate

  point = 1 + rand(parent1.size-2)
  return parent1[0...point]+parent2[point...(parent1.size)]
end

# Randomly match two people in the population next to each other
def reproduce(selected, pop_size, p_cross, p_mutation)
  children = []

  pop_size.times do
    p1, p2 = selected.sample(2)
    children << point_mutation(crossover(p1, p2, p_cross), p_mutation)
  end
  return children
end

def search(max_gens, num_bits, pop_size, p_crossover, p_mutation)
  population = Array.new(pop_size){Array.new(num_bits){rand(0..1)}}
  best = best_from_population(population)
  max_gens.times do |gen|
    selected = Array.new(pop_size){binary_tournament(population)}
    children = reproduce(selected, pop_size, p_crossover, p_mutation)
    curr = best_from_population(children)
    best = curr if fitness(curr) > fitness(best)
    population = children
    puts " > gen #{gen}, best: #{fitness(best)}, #{best.join}"
    break if fitness(best) == num_bits
  end
  return best
end


# problem configuration
num_bits = 64
# algorithm configuration
max_gens = 100
pop_size = 100
p_crossover = 0.98
p_mutation = 1.0/num_bits
# execute the algorithm
best = search(max_gens, num_bits, pop_size, p_crossover, p_mutation)
puts "done! Solution: f=#{fitness(best)}, s=#{best.join}"
