module GameScript

def play_game
  puts "Turn #{@turn}, #{@to_play} to play"
  pp @board
  if @to_play == "white"
    if self.white_king_check?
      if self.checkmate?
        puts "Game over on turn #{turn}, black won via checkmate"
        exit
      end
    end
  elsif self.black_king_check?
    if self.checkmate?
      puts "Game over on turn #{turn}. white won via checkmate"
      exit
    end
  end
  if @computer == 'white' && @to_play == "white"
    puts "Computer is making a move"
    self.random_computer_move
    puts "Moved #{@last_piece_moved.values.first} from square #{@last_piece_moved.keys.first} to square #{@last_piece_moved.keys.last}"

  elsif @computer == 'black' && @to_play == "black"

    puts "Computer is making a move"
    self.random_computer_move
    puts "Moved #{@last_piece_moved.values.first} from square #{@last_piece_moved.keys.first} to square #{@last_piece_moved.keys.last}"
  else
    puts "Please choose a piece to move (a1 - h8) or type 'save'"
    self.choose_square
    self.check_valid_moves
    pp @valid_moves
    if @valid_moves.empty?
      puts "No legal moves for this piece"
      return self.play_game
    end

    puts "Here are the squares your #{selected_piece} can move to"
    pp @valid_moves
    puts "Please pick a square"
    self.make_move
  end

  if @to_play == "white"
    @to_play = "black"
  elsif @to_play == "black"
    @turn += 1
    @to_play = "white"
  end
  self.play_game
end

def new_game_or_load
  puts "Would you like to start a new game, or load one? [new / load]"
  answer = gets.chomp
  unless answer.downcase == 'new' || answer.downcase == 'load'
    return self.new_game_or_load
  end
  case answer.downcase
    when 'new'
      computer_or_player
    when 'load'
      load_game
  end
end

def computer_or_player
  puts "Would you like to play against the computer, or another person? [computer / player]"
  answer = gets.chomp
  unless answer.downcase == 'computer' || answer.downcase == 'player'
    puts "Must choose computer or player"
    return computer_or_player
  end

  case answer.downcase
  when 'computer'
    puts "Would you like to play as white or black? [ white / black]"
    colour_answer = gets.chomp
    unless colour_answer.downcase == 'white' || colour_answer.downcase == 'black'
      puts "Must choose white or black"
      return self.computer_or_player
    end

    if colour_answer == 'white'
      game = Chess.new
      game.computer = 'black'
      game.play_game

    elsif colour_answer == 'black'

      game = Chess.new
      game.computer = 'white'
      game.play_game
    end

  when 'player'
    game = Chess.new
    game.play_game
  end
end
