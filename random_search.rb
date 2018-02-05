
# assert(400, random_search(num_iterations: 10, search_space: [10, 30, 1, 9, -100, 400, -10, 4, 40, 0]))
# assert(977, random_search(num_iterations: 100, search_space: [913, 343, 977, 412, 921, 95, 758, 906, 486, 203, 681, 211, 729, 216, 487, 752, 684, 414, 911, 255, 955, 879, 77, 670, 797, 457, 498, 94, 10, 376, 457, 637, 204, 776, 327, 97, 117, 627, 288, 618, 148, 418, 374, 834, 401, 358, 111, 651, 952, 756, 529, 692, 682, 350, 938, 443, 741, 710, 676, 1, 242, 70, 32, 457, 53, 772, 383, 181, 646, 182, 113, 463, 901, 464, 26, 707, 956, 343, 643, 116, 745, 318, 928, 685, 404, 97, 211, 179, 727, 202, 457, 577, 120, 755, 824, 161, 884, 546, 230, 32]))
def cost(vector)
  return vector.inject(0) {|sum, x| sum + (x ** 2.0)}
end

# The vector to search
def random_vector(min, max, problem_size)
  [rand(min.to_f...max)] * problem_size
end

def search(min, max, problem_size, max_iter)
  best = nil
  max_iter.times do |iter|
    candidate = random_vector(min, max, problem_size)
    best = candidate if best.nil? || cost(candidate) < cost(best)
    puts " > iteration=#{(iter+1)}, best=#{cost(best)}"
  end
  return best
end

if __FILE__ == $0
  # problem configuration
  problem_size = 2
  min = -5
  max = 5

  # algorithm configuration
  max_iter = 100
  # execute the algorithm
  best = search(min, max, problem_size, max_iter)
  puts "Done. Best Solution: c=#{cost(best)}, v=#{best.inspect}"
end
