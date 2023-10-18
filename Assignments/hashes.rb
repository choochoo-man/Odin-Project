# Given a hash of family members, with keys as the title and an array of names as the values, use Ruby's built-in select method to gather only siblings' names into a new array.

family = {  uncles: ["bob", "joe", "steve"],
  sisters: ["jane", "jill", "beth"],
  brothers: ["frank","rob","david"],
  aunts: ["mary","sally","susan"]
}

# names_array = family.select.values {|keys, values| keys == :sisters || keys == :brothers}

names_array = family.select {|key, values| [:sisters, :brothers].include?(key)}

p names_array.values.flatten

films = {lord_of_the_rings: 2001, the_godfather: 1989, the_martian: 2015}
puts films.each_key {|key| puts key}
puts films.each_value {|value| puts value}
puts films.each {|key, value| puts "The key is #{key}, and the value is #{value}"}

puts films.keys

if films.value?(2001)
  puts "Wahoo"
else
  puts "Uh oh"
end
