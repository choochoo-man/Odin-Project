require 'matrix'
gem 'matrix'
require 'pry'

puts "Player 1's name? (playing as 0's)"
playerone = gets.chomp
puts "Player 2's name? (playing as X's)"
playertwo = gets.chomp

REFERENCEBOARD = 
[[1, 2, 3],
[4, 5, 6],
[7, 8, 9]]

board = 
[[nil, nil, nil],
[nil, nil, nil],
[nil, nil, nil]]

turn = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def newturn(player, pieces, board)
  puts "It's #{player}'s turn to play as #{pieces}'s"
  puts "Here is the current board state"
  p board[0]
  p board[1]
  p board[2]
  puts "Please pick a position to play 1-9"
  p REFERENCEBOARD[0]
  p REFERENCEBOARD[1]
  p REFERENCEBOARD[2]
  self.position(player, pieces, board)
end

def position(player, pieces, board)
  square = gets.chomp
  unless [1, 2, 3, 4, 5, 6, 7, 8, 9].include?(square.to_i)
    puts "You must pick a number between 1 and 9"
    return self.position(player, pieces, board)
  end
  squareindex = Matrix[ [1, 2, 3], [4, 5, 6], [7, 8, 9] ].index(square.to_i)
  row = squareindex[0]
  column = squareindex[1]
  if board[row][column] == nil
    board[row][column] = pieces
  else
    puts "You must pick an empty square"
    self.position(player, pieces, board)
  end
end

def player_one_wins?(board)
  flat_board = board.flatten
  toprow = flat_board.values_at(0, 1, 2)
  midrow = flat_board.values_at(3, 4, 5)
  botrow = flat_board.values_at(6, 7, 8)
  leftcol = flat_board.values_at(0, 3, 6)
  midcol = flat_board.values_at(1, 4, 7)
  rightcol = flat_board.values_at(2, 5, 8)
  leftdia = flat_board.values_at(0, 4, 8)
  rightdia = flat_board.values_at(2, 4, 6)
  if toprow.count("0") == 3
    return true
  end
  if midrow.count("0") == 3
    return true
  end
  if botrow.count("0") == 3
    return true
  end
  if leftcol.count("0") == 3
    return true
  end
  if midcol.count("0") == 3
    return true
  end
  if rightcol.count("0") == 3
    return true
  end
  if leftdia.count("0") == 3
    return true
  end
  if rightdia.count("0") == 3
    return true
  end
  return false
end

def player_two_wins?(board)
  flat_board = board.flatten
  toprow = flat_board.values_at(0, 1, 2)
  midrow = flat_board.values_at(3, 4, 5)
  botrow = flat_board.values_at(6, 7, 8)
  leftcol = flat_board.values_at(0, 3, 6)
  midcol = flat_board.values_at(1, 4, 7)
  rightcol = flat_board.values_at(2, 5, 8)
  leftdia = flat_board.values_at(0, 4, 8)
  rightdia = flat_board.values_at(2, 4, 6)
  if toprow.count("X") == 3
    return true
  end
  if midrow.count("X") == 3
    return true
  end
  if botrow.count("X") == 3
    return true
  end
  if leftcol.count("X") == 3
    return true
  end
  if midcol.count("X") == 3
    return true
  end
  if rightcol.count("X") == 3
    return true
  end
  if leftdia.count("X") == 3
    return true
  end
  if rightdia.count("X") == 3
    return true
  end
  return false
end



turn.each do |value|
  if value.odd?
    player = playerone
    pieces = "0"
  end
  if value.even?
    player = playertwo
    pieces = "X"
  end

  if self.player_one_wins?(board)
    p board[0]
    p board[1]
    p board[2]
    p "#{playerone} has won on turn #{value}!"
    break
  end

  if self.player_two_wins?(board)
    p board[0]
    p board[1]
    p board[2]
    p "#{playertwo} has won on turn #{value}!"
    break
  end

  puts "Starting turn #{value}"
  newturn(player, pieces, board)
end
