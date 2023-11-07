

class HangMan
  attr_accessor :target_word, :target_word_array, :display, :guessed_letters


  def initialize
    wordlist = File.open("lib/google-10000-english-no-swears.txt")
    words = File.readlines(wordlist)  
    @target_word = words.select {|v| v.length > 5 && v.length < 12}.sample.chomp
    @target_word_array = @target_word.split("")
    @display = Array.new(@target_word_array.length, "_")
    @guessed_letters = []
  end

  def win_condition?(newgame)
    if newgame.display == newgame.target_word_array
      return true
    else
      return false
    end
  end

  def guess(newgame, t)
    puts self.display.join(" ")
    puts "Please guess a letter"

    letter = gets.chomp.downcase

    unless ("a".."z").include? letter
      puts "Must pick a letter a-z"

      return self.guess(newgame, t)
    end

    @target_word_array.each_with_index do |l, i|
      if l.include? letter
        @display[i] = @target_word_array[i]
      end   
    end

    unless @target_word_array.include? letter
      @guessed_letters << letter
      puts "You have guessed the following letters"
      puts @guessed_letters.join(" ")
    end
  end
end

newgame = HangMan.new
# puts newgame.target_word
(1..10).each do |t|
  unless t == 1
    puts "Turn #{t} board: #{newgame.display}"
  end 

  newgame.guess(newgame, t)

  if newgame.win_condition?(newgame) == true
    puts "You won on turn #{t}, the word was #{newgame.target_word}"
    break
  end

  if t == 10
    puts "Game over, the word was #{newgame.target_word}"
  end
end
