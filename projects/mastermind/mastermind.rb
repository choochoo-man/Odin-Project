# 12 turns, 6 colours, 4 slots for each turn

turns = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
secretcode = ["red", "red", "blue", "green"]
colours = ["red", "blue", "green", "purple", "yellow", "orange"]

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
  if secretcode == board[turn - 2]
    return true

  else
    return false
  end
end

def positionone(board, turn, colours)
  puts "please choose a colour for position 1"
  pos_one = gets.chomp
  if colours.include?(pos_one)
    board[turn - 1][0] = pos_one
  else
    puts "Must pick red, green, blue, yellow, orange or purple"
    return self.positionone(board, turn, colours)
  end
end

def positiontwo(board, turn, colours)
  puts "please choose a colour for position 2"
  pos_two = gets.chomp
  if colours.include?(pos_two)
    board[turn - 1][1] = pos_two
  else
    puts "Must pick red, green, blue, yellow, orange or purple"
    return self.positiontwo(board, turn, colours)
  end
end

def positionthree(board, turn, colours)
  puts "please choose a colour for position 3"
  pos_three = gets.chomp
  if colours.include?(pos_three)
    board[turn - 1][2] = pos_three
  else
    puts "Must pick red, green, blue, yellow, orange or purple"
    return self.positionthree(board, turn, colours)
  end
end

def positionfour(board, turn, colours)
  puts "please choose a colour for position 4"
  pos_four = gets.chomp
  if colours.include?(pos_four)
    board[turn - 1][3] = pos_four
  else
    puts "Must pick red, green, blue, yellow, orange or purple"
    return self.positionfour(board, turn, colours)
  end
end

def check(board, turn, secretcode)
  if board[turn - 1][0] == secretcode[0]
    puts "Position 1 is the correct colour"
  end

  if board[turn - 1][0] != secretcode[0] && secretcode.include?(board[turn - 1][0])
    puts "Position 1 colour is used but not here"
  end

  if board[turn - 1][1] == secretcode[1]
    puts "Position 2 is the correct colour"
  end

  if board[turn - 1][1] != secretcode[1] && secretcode.include?(board[turn - 1][1])
    puts "Position 2 colour is used but not here"
  end 

  if board[turn - 1][2] == secretcode[2]
    puts "Position 3 is the correct colour"
  end

  if board[turn - 1][2] != secretcode[2] && secretcode.include?(board[turn - 1][2])
    puts "Position 3 colour is used but not here"
  end 

  if board[turn - 1][3] == secretcode[3]
    puts "Position 4 is the correct colour"
  end

  if board[turn - 1][3] != secretcode[3] && secretcode.include?(board[turn - 1][3])
    puts "Position 4 colour is used but not here"
  end 
end

turns.each do |turn|
  displayboard = board.map(&:compact).reject(&:empty?)
  if self.correctcode?(board, turn, secretcode)
    puts "You have correctly guessed the code!"
    pp displayboard
    break
  end
  puts "Here is the current board state on turn #{turn}"
  pp displayboard

  self.positionone(board, turn, colours)
  self.positiontwo(board, turn, colours)
  self.positionthree(board, turn, colours)
  self.positionfour(board, turn, colours)
  self.check(board, turn, secretcode)
end
