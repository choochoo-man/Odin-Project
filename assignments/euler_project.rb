require 'prime'
# Find the sum of all the multiples of 3 or 5 below 1000
# answer should be 233168
def problem_one(n)
  sum = 0
  (1..n-1).each do |value|
    if value % 3 == 0 || value % 5 == 0
        sum += value
    end
  end
  sum
end

# pp problem_one(1000)

# By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
# answer should be 4613732

def problem_two(value = 0)
  results_array = [0]
 until results_array.last > 4000000
    if value < 2
      results_array << value
      value += 1
    else
      results_array << results_array[-1] + results_array[-2]
    end
    pp results_array
  end
  results_array.pop
  pp results_array
  answer =  results_array.select{|num| num.even?}.sum
  answer
end

# puts problem_two

# What is the largest prime factor of the number 600851475143
# answer should be 6857
def problem_three(n)
  Prime.prime_division(n).max_by(&:first).first
end


# pp problem_three(600851475143)


# Find the largest palindrome made from the product of two 3-digit numbers. Answer should be 906609

def reverse_integer(n)
 reversed = n.to_s.reverse.to_i
end

palindromes = []

(100..999).each do |number|
  (100..999).each do |value|
    product = number * value
    if product == reverse_integer(product)
      palindromes << product
    end
  end
end
# pp palindromes.max

# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20 ? 232792560

def one_twenty(value, n = 1, answer = nil)
  if n <= 20
    if value % n == 0
      n+= 1
      one_twenty(value, n)
    elsif value % n != 0
      return
    end
  else
    answer = value
    puts "The answer is #{answer}"
    exit
  end
end


(1..).each do |number|
  puts number
  one_twenty(number)
end









