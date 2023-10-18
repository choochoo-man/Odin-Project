def fullname(firstname, lastname)
    firstname + " " + lastname
end
puts fullname("Daniel", "Abraham")


def fullnamearray(firstname, lastname)
    [firstname, lastname].join(" ")
end
puts fullnamearray("Daniel", "Abraham") 


#Use the modulo operator, division, or a combination of both to take a 4 digit number and find the digit in the: 1) thousands place 2) hundreds place 3) tens place 4) ones place

def digitcount(input) 
   thousands = input.to_i / 1000
   hundreds = (input.to_i / 100) % 10
   tens = (input.to_i / 10) % 10
   ones = input.to_i % 10
  "Your four digit number has #{thousands} thousands, #{hundreds} hundreds, #{tens} tens and #{ones} ones!"
end
puts digitcount(4678)

#Write a program that uses a hash to store a list of movie titles with the year they came out. 
#Then use the puts command to make your program print out the year of each movie to the screen. The output for your program should look something like this.

movieyear = {
  the_godfather: {
    year: 1989,
    title: "The Godfather"
    },
  lord_of_the_rings: {
    year: 2001,
    title: "The Lord of The Rings"
  },
  the_martian: {
    year: 2015,
    title: "The Martian"
  }
}
puts movieyear.values

movieyearhash = {the_godfather: 1989, lord_of_the_rings: 2001, the_martian: 2015}
pp movieyearhash.values

#Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

class Integer
  def fact
      (1..self).reduce(:*) || 1
  end
end
  def factorial(input1, input2, input3, input4)
  answer1 = input1.fact
  answer2 = input2.fact
  answer3 = input3.fact
  answer4 = input4.fact
"The factorial of #{input1} is #{answer1}, the factorial of #{input2} is #{answer2}, the factorial of #{input3} is #{answer3}, the factorial of #{input4} is #{answer4}"
end
puts factorial(5, 6, 7, 8)

#Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen.

def squarefloat(input1, input2, input3)
  answer1 = input1 * input1
  answer2 = input2 * input2
  answer3 = input3 * input3
  "The square of #{input1} is #{answer1}, the square of #{input2} is #{answer2} and the square of #{input3} is #{answer3}"
end
puts squarefloat(5.4, 6.2, 7.8)
 