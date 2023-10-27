# frozen_string_literal: true

def tencharacters(input_1)
  return unless input_1.length >= 10

  input_1.upcase
end

puts tencharacters('hello_world')

puts 'Please choose a number'
input_1 = gets.chomp
if input_1.to_i <= 50
  puts 'your number is between 0 and 50'
elsif input_1.to_i > 50 && input_1.to_i < 101
  puts 'your number is between 51 and 100'
elsif input_1.to_i > 100
  puts 'your number is greater than 100'
end
