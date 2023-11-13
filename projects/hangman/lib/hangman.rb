require 'yaml'
require 'pry'

class HangMan
  attr_accessor :target_word, :target_word_array, :display, :guessed_letters, :wrong_guesses

  def initialize
    wordlist = File.open("lib/google-10000-english-no-swears.txt")
    words = File.readlines(wordlist)  
    @target_word = words.select {|v| v.length > 5 && v.length < 12}.sample.chomp
    @target_word_array = @target_word.split("")
    @display = Array.new(@target_word_array.length, "_")
    @guessed_letters = []
    @wrong_guesses = 0
  end

  def win_condition?
    if display == target_word_array
      return true
    else
      return false
    end
  end

  def save_game
    puts "What would you like to call the saved game?"
    game_name = gets.chomp.downcase
    game_hash = 
    {target_word: target_word,
     display: display, 
     guessed_letters: guessed_letters,
     wrong_guesses: wrong_guesses }
    serialized_game = YAML::dump(game_hash)
    File.write("lib/saves/#{game_name}.rb", serialized_game)
    exit
  end

  def guess
    puts self.display.join(" ")
    puts "Please guess a letter (or press save)"

    letter = gets.chomp.downcase

    unless letter.downcase == "save" || ("a".."z").include?(letter)
      puts "Must pick a letter a-z (or save)"

      return guess
    end

    if letter.downcase == "save"
      self.save_game
      return
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
      self.wrong_guesses += 1
    end

    # self.wrong_guesses += 1/
  end

  def play_game
    while wrong_guesses < 12
      unless wrong_guesses ==1
        puts "#{wrong_guesses} wrong guesses, board: #{display}"
      end 
      guess
  
      if win_condition? == true
        puts "You won with #{wrong_guesses} wrong guesses, the word was #{target_word}"
        break
      end
    end
  
    if wrong_guesses == 12
      puts "Game over, the word was #{target_word}"
    end
  end
  
  def load_game
    puts Dir.entries("lib/saves")
    puts "Please pick a game to load"
    response = gets.chomp
    serialized_game = File.open("lib/saves/#{response}", "r")
    unserialized_game = YAML::load_file(serialized_game)
    @target_word = unserialized_game[:target_word]
    @target_word_array = @target_word.split("")
    @display = unserialized_game[:display]
    @guessed_letters = unserialized_game[:guessed_letters]
    @wrong_guesses = unserialized_game[:wrong_guesses]
    self.play_game
  rescue Errno::ENOENT
    self.load_game
  end
  
  def picker
    puts "Would you like to start a new game, or load a previous game? (New/Load)"
  answer = gets.chomp.downcase
    unless answer == "new" || answer == "load"
      return self.picker
    end
  
    if answer.downcase == "new"
      self.play_game
    end
  
    if answer.downcase == "load"
     self.load_game
    end
  end
end

game = HangMan.new
game.picker
