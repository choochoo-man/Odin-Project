# 12 turns, 6 colours, 4 slots for each turn
require 'pry'

turns = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

secretcode = %w[red red blue green]

colours = %w[red blue green purple yellow orange]

slots = [0, 1, 2, 3]

answer = nil

guess = 'red'

board =
  [[nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil],
   [nil, nil, nil, nil]]

def correctcode?(board, turn, secretcode)
  return true if secretcode == board[turn - 2]

  false
end

def position(board, turn, colours, slots)
  puts "please choose a colour for position #{slots + 1} (red, green, blue, yellow, orange or purple)"
  pos = gets.chomp
  if colours.include?(pos)
    board[turn - 1][slots] = pos
  else
    puts 'Must pick red, green, blue, yellow, orange or purple'
    position(board, turn, colours, slots)
  end
end

def check(board, turn, secretcode, slots)
  puts "Position #{slots + 1} is the correct colour" if board[turn - 1][slots] == secretcode[slots]

  return unless board[turn - 1][slots] != secretcode[slots] && secretcode.include?(board[turn - 1][slots])

  puts "Position #{slots + 1} colour is used but not here"
end

def pick(answer, board, turns, secretcode, slots, colours, guess)
  puts "Would you like to set the code, or break it? (type 'Set' or 'Break')"
  answer = gets.chomp
  unless answer.downcase == 'set' || answer.downcase == 'break'
    puts "Must pick 'Set' or 'Break'"
    return pick(answer, board, turns, secretcode, slots, colours, guess)
  end
  setcode(board, turns, secretcode, slots, colours, guess) if answer.downcase == 'set'
  return unless answer.downcase == 'break'

  breakcode(board, turns, secretcode, slots, colours)
end

def decodecheck; end

def decode(board, turns, secretcode, slots, colours, guess)
  solution = [nil, nil, nil, nil]

  turns.each do |turn|
    if solution == secretcode
      puts 'Code cracked!'
      puts solution.join(' ')
      break
    end

    slots.each do |slot|
      guess = colours.sample

      unless solution[slot] == secretcode[slot]
      solution[slot] = guess
      end
    end

    puts "Here is the current board state on turn #{turn}"
    pp solution
  end
end

def setcode(board, turns, secretcode, slots, colours, guess)
  slots.each { |slots| setsecretcode(board, turns, secretcode, colours, slots) }
  puts "Would you like to break the code yourself, or have the program (type 'Me' or 'Program')"
  answer = gets.chomp
  unless answer.downcase == 'me' || answer.downcase == 'program'
    puts "Must pick 'Me' or 'Program'"
    return setcode(board, turns, secretcode, slots, colours, guess)
  end
  decode(board, turns, secretcode, slots, colours, guess) if answer.downcase == 'program'
  return unless answer.downcase == 'me'

  breakcode(board, turns, secretcode, slots, colours)
end

def setsecretcode(board, turns, secretcode, colours, slots)
  puts "please choose a colour for position #{slots + 1} (red, green, blue, yellow, orange or purple)"
  pos = gets.chomp
  if colours.include?(pos)
    secretcode[slots] = pos
  else
    puts 'Must pick red, green, blue, yellow, orange or purple'
    self.setsecretcode(board, turns, secretcode, colours, slots)
  end
end

def breakcode(board, turns, secretcode, slots, colours)
  turns.each do |turn|
    displayboard = board.map(&:compact).reject(&:empty?)

    if correctcode?(board, turn, secretcode)
      puts 'You have correctly guessed the code!'
      puts board[turn - 2].join(' ')
      break
    end
    unless turn == 1
      puts '- * - * - * - * - * - * - * - * - * - * - * -'
      puts "Here is the current board state on turn #{turn}"
      displayboard.each { |play| puts play.join(' ') }
    end

    slots.each { |slots| position(board, turn, colours, slots) }

    slots.each { |slots| check(board, turn, secretcode, slots) }
  end
end

pick(answer, board, turns, secretcode, slots, colours, guess)
