# frozen_string_literal: true

# Write a while loop that takes input from the user, performs an action,
# and only stops when the user types "STOP". Each loop can get info from the user.

answer = ' '
while answer != 'STOP'
  puts 'What do you want to do?'
  answer = gets.chomp
  puts 'Here we go again'
end

# Write a method that counts down to zero using recursion.

def countdown(number_1)
  puts number_1
  return unless number_1.positive?

  countdown(number_1 - 1)
end

countdown(12)
