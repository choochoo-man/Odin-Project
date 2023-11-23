# Using iteration, write a method #fibs which takes a number and returns an array containing 
# that many numbers from the Fibonacci sequence. Using an example input of 8, this method 
# should return the array [0, 1, 1, 2, 3, 5, 8, 13].

def fibs(n)
  results_array = []
  (0..n - 1).each do |value|
    if value < 2
      results_array << value
    else
      results_array << results_array[-1] + results_array[-2]
    end
  end

  pp results_array
end

fibs(8)

# Now write another method #fibs_rec which solves the same problem recursively. This can be 
# done in just 3 lines (or 1 if you’re crazy, but don’t consider either of these lengths
#  a requirement… just get it done).

def fibs_rec(n, c = 0, results_array = [])
    unless c > n - 1
      if c < 2
        results_array << c
      else
        results_array << results_array[-1] + results_array[-2]
      end
      c += 1
      fibs_rec(n, c, results_array)
    end

    if c > n - 1
      pp results_array
      exit
    end
end

fibs_rec(8)