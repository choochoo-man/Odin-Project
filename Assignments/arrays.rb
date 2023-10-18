arr = [1, 3, 5, 7, 9, 11]
number = 3
if arr.include? number
  puts "#{arr} does contain #{number}"
else
  puts "#{arr} does not contain #{number}"
end

#Use the each_with_index method to iterate through 
#an array of your creation that prints each index and value of the array.

array_2 = ["The Fellowship of The Ring", "The Two Towers", "The Return of the King"]
array_2.each_with_index { |val, idx| puts "#{idx}. #{val}"}

#Write a program that iterates over an array and builds a new array that is the result 
#of incrementing each value in the original array by a value of 2. You should have two 
#arrays at the end of this program, The original array and the new array you've created. 
#Print both arrays to the screen using the p method instead of puts

array_3 = [1,2,3,4,5,6,7,8]
array_3_map = array_3.map do |valu|
  valu + 2
end
p array_3
p array_3_map

