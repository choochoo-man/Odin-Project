require_relative 'bishop'
require_relative 'checkmate'
require_relative 'computer'
require_relative 'game_script'
require_relative 'king'
require_relative 'pawn'
require_relative 'piece_movements'
require_relative 'queen'
require_relative 'rook'
require_relative 'save_load'

class Board
    attr_accessor :board, :valid_squares, :position, :position_index, :white_pieces, :black_pieces, :valid_moves, :letters_to_coords, :selected_piece, :white_king_position, :black_king_position, :turn, :to_play, :piece_positions, :last_piece_moved, :has_moved, :computer
  def initialize(board = Array.new(4) {Array.new(8, "_")}, turn = 1, to_play = "white", last_piece_moved = nil, has_moved = {black_a_rook: "no", black_h_rook: "no", black_king: "no", white_a_rook: "no", white_h_rook: "no", white_king: "no"}, white_king_position = [7, 4], black_king_position = [0, 4])
    @board = board
    @turn = turn
    @to_play = to_play
    @has_moved = has_moved
    @last_piece_moved = last_piece_moved
    @valid_squares = []
    @position = nil
    @position_index = nil
    @white_pieces = %w[♙ ♘ ♗ ♖ ♕ ♔]
    @black_pieces = %w[♟︎ ♞ ♝ ♜ ♛ ♚]
    @valid_moves = []
    @letters_to_coords = %w[a b c d e f g h]
    @selected_piece = nil
    @white_king_position = white_king_position
    @black_king_position = black_king_position
    @piece_positions = {}
    @computer = nil
    if @board.size == 4
      @board << %w[♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙]
      @board << %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖]
      @board.unshift(%w[♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎])
      @board.unshift(%w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜])
    end

    ("a".."h").each do |letter|
      (1..8).each do |number|
        @valid_squares << "#{letter}#{number}"

      end
    end
  end

  def choose_square(answer = gets.chomp)

    unless @valid_squares.include?(answer) || answer.downcase == 'save'
      return choose_square

    end

    if @valid_squares.include?(answer)
      self.position = answer

    elsif answer.downcase == 'save'
      self.save_game
    end
    self.identify_piece
  end

  def identify_piece(position = @position)
    @position_index = position.split("")
    @position_index[0] = self.letters_to_coords.find_index(position_index[0])
    @position_index[1] = 8 - position_index[1].to_i
    @selected_piece = self.board[position_index[1]][position_index[0]]
    friends = @to_play == "white" ? @white_pieces : @black_pieces
    unless friends.include?(@selected_piece)
      puts "Must choose a #{@to_play} piece to move"

      return self.choose_square
    end

    case @selected_piece
    when "♙"
      self.white_pawn
    when "♟︎"
      self.black_pawn
    when "♘"
      self.knight
    when "♞"
      self.knight
    when "♗"
      self.bishop
    when "♝"
      self.bishop
    when "♖"
      self.rook
    when "♜"
      self.rook
    when "♕"
      self.queen
    when "♛"
      self.queen
    when "♔"
      self.white_king
    when "♚"
      self.black_king
    else
      puts "Piece not found"
      return self.play_game

    end
  end

  def coords_to_square(coords)
    return "#{self.letters_to_coords[coords[1]]}" + "#{8 - coords[0]}"
  end

  def update_last_piece_moved(selected_piece, answer, position_index)
    @last_piece_moved = {}
    @last_piece_moved[position] = selected_piece  #from
    @last_piece_moved[answer] = selected_piece    #to
  end

  def make_move(answer = gets.chomp)
    unless @valid_moves.include?(answer)
      return self.make_move
    end

    self.update_last_piece_moved(@selected_piece, answer, @position)
    answer_index = answer.split("")
    answer_index[0] = self.letters_to_coords.find_index(answer_index[0])
    answer_index[1] = 8 - answer_index[1].to_i

    case @selected_piece
    when "♔"
      @white_king_position[0] = answer_index[1]
      @white_king_position[1] = answer_index[0]
      @has_moved[:white_king] = "yes"
    when "♚"
      @black_king_position[0] = answer_index[1]
      @black_king_position[1] = answer_index[0]
      @has_moved[:black_king] = "yes"
    when "♖"
      if @position_index == [0, 7]
        @has_moved[:white_a_rook] = "yes"
      elsif  @position_index == [7, 7]
        @has_moved[:white_h_rook] = "yes"
      end
    when "♜"
      if @position_index == [0, 0]
        @has_moved[:black_a_rook] = "yes"
      elsif  @position_index == [7, 0]
        @has_moved[:black_h_rook] = "yes"
      end
    end
    if answer == "O-O"
      case @selected_piece
      when "♔"
        @board[7][4] = "_"
        @board[7][6] = "♔"
        @board[7][7] = "_"
        @board[7][5] = "♖"
        @white_king_position = [7, 6]

      when "♚"
        @board[0][4] = "_"
        @board[0][6] = "♚"
        @board[0][7] = "_"
        @board[0][5] = "♜"
        @black_king_position = [0, 6]

      end
    elsif answer == "O-O-O"
      case @selected_piece
      when "♔"
        @board[7][4] = "_"
        @board[7][2] = "♔"
        @board[7][0] = "_"
        @board[7][3] = "♖"
        @white_king_position = [7, 2]
      when "♚"
        @board[0][4] = "_"
        @board[0][2] = "♚"
        @board[0][0] = "_"
        @board[0][3] = "♜"
        @black_king_position = [0, 2]
      end
    else

      if @selected_piece == "♙"

        if answer_index[1] == 0
          self.promotion("white", answer_index[0])

        elsif position.split("").first != answer.split("").first && self.board[answer_index[1]][answer_index[0]] == "_"
          self.board[answer_index[1]][answer_index[0]] = @selected_piece
          self.board[position_index[1]][position_index[0]] = "_"
          self.board[answer_index[1] + 1][answer_index[0]] = "_"

        else
          self.board[answer_index[1]][answer_index[0]] = @selected_piece
          self.board[position_index[1]][position_index[0]] = "_"

        end


      elsif @selected_piece == "♟︎"

        if answer_index[1] == 7
          self.promotion("black", answer_index[0])

        elsif position.split("").first != answer.split("").first && self.board[answer_index[1]][answer_index[0]] == "_"
          self.board[answer_index[1]][answer_index[0]] = @selected_piece
          self.board[position_index[1]][position_index[0]] = "_"
          self.board[answer_index[1] - 1][answer_index[0]] = "_"

        else
          self.board[answer_index[1]][answer_index[0]] = @selected_piece
          self.board[position_index[1]][position_index[0]] = "_"
        end

      else
        self.board[answer_index[1]][answer_index[0]] = @selected_piece

        self.board[position_index[1]][position_index[0]] = "_"


      end
    end
  end

  def white_pawn
    movement_coords = Coordinates.white_pawn_moves

    attack_coords = Coordinates.white_pawn_attacks

    pawn_options(movement_coords, attack_coords)

  end

  def bishop
  relative_coords = Coordinates.bishop_moves
  iterative_options(relative_coords)
  end

  def knight
  relative_coords = Coordinates.knight_moves

  knight_options(relative_coords)

  end

  def rook
  relative_coords = Coordinates.rook_moves
  iterative_options(relative_coords)
  end

  def queen
  relative_coords = Coordinates.queen_moves
  iterative_options(relative_coords)
  end

  def white_king
  relative_coords = Coordinates.king_moves
    king_options(relative_coords)
  end

  def black_pawn
  movement_coords = Coordinates.black_pawn_moves

  attack_coords = Coordinates.black_pawn_attacks

  pawn_options(movement_coords, attack_coords)
  end

  def black_king
  relative_coords = Coordinates.king_moves
  king_options(relative_coords)
  end
end
