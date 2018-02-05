def cost(vector)
  return vector.sum
end

# Mutate only one random position
def random_neighbor(bitstring)
  mutant = bitstring.clone
  i = rand(bitstring.size)
  mutant[i] = mutant[i] == 1 ? 0 : 1
  return mutant
end

def search(candidate, max_iterations, num_bits)
  puts "Optimizing candidate #{candidate.join}"

  max_iterations.times do |i|
    neighbor = random_neighbor(candidate)
    candidate = neighbor if cost(neighbor) >= cost(candidate)
    puts neighbor.join

    puts " > iteration #{(i+1)}, best=#{cost(candidate)}"
    break if cost(candidate) == num_bits
  end
  return candidate
end

if __FILE__ == $0
  # problem configuration
  num_bits = 64
  # algorithm configuration
  max_iterations = 1000

  candidate = Array.new(num_bits){ rand(0..1)}

  # execute the algorithm
  best = search(candidate, max_iterations, num_bits)
  puts "Done. Best Solution: c=#{cost(best)}, v=#{best.join}"
end
