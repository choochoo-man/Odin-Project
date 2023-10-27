
require 'pry'
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# found_matches = []

def substrings(*input, dictionary)#, found_matches)
  # dictionary.each do |word|
    # if input.to_s.include?(word)
    #   found_matches << word
    # end
   dictionary.select { |word| input.to_s.include?(word)}.tally
  #  found_matches.tally
end

p substrings("below", "partner", dictionary)#, found_matches)
# binding.pry

