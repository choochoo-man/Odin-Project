# Write a program called name.rb that asks the user to type in their name and then prints 
# out a greeting message with their name included.

puts "What is your first name?" #added after viewing solution
first_name = gets.chomp
puts "What is your last name?"
last_name = gets.chomp
puts "Welcome #{first_name + " " + last_name}!" 
# puts "Here is your name 10 times :) #{name * 10}"

# 10.times do
# puts name
# end

# Write a program called age.rb that asks a user how old they are and then tells them
# how old they will be in 10, 20, 30 and 40 years.

puts "How old are you?"
age = gets.chomp
age_in_10 = age.to_i + 10
age_in_20 = age.to_i + 20
age_in_30 = age.to_i + 30
age_in_40 = age.to_i + 40
puts "If you are #{age} years old, in 10 years you will be #{age_in_10}, in 20 years you
will be #{age_in_20}, in 30 years you will be #{age_in_30}, in 40 years you will be #{age_in_40}"

# Write a program that checks if the sequence of characters "lab" exists in the following 
# strings.If it does exist, print out the word.
# "laboratory" "experiment" "Pans Labyrinth" "elaborate" "polar bear"
wordsarray = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

wordsarray.each do |w|
  #w.gsub(" ", "")
  if w.downcase.include?("lab")
    puts w
  end
end

