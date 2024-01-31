# White pieces: Pawn: ♙, Knight: ♘, Bishop: ♗, Rook: ♖, Queen: ♕, King: ♔
# Black pieces: Pawn: ♟︎, Knight: ♞, Bishop: ♝, Rook: ♜, Queen: ♛, King: ♚
require 'yaml'
require_relative './piece_movements.rb'
include Coordinates


class Chess
  attr_accessor :board, :valid_squares, :position, :position_index, :white_pieces, :black_pieces, :valid_moves, :letters_to_coords, :selected_piece, :white_king_position, :black_king_position, :turn, :to_play, :piece_positions, :last_piece_moved, :has_moved
  def initialize(board = Array.new(4) {Array.new(8, "_")}, turn = 1, to_play = "white", last_piece_moved = nil, has_moved = {black_a_rook: "no", black_h_rook: "no", black_king: "no", white_a_rook: "no", white_h_rook: "no", white_king: "no"}, white_king_position = [7, 0], black_king_position = [0, 4])
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

  def choose_square
    puts "Please choose a piece to move (a1 - h8) or type 'save'"
    answer = gets.chomp

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

  def pawn_options(movement_coords, attack_coords)
    self.valid_moves = []
    attack_coords.each do |a_coords|
      if self.valid_squares.include?(coords_to_square([position_index[1] + a_coords[1], position_index[0] + a_coords[0]]))
        enemies = self.white_pieces.include?(self.selected_piece) ? self.black_pieces : self.white_pieces

        square_being_looked_at = self.board[position_index[1] + a_coords[1]][position_index[0] + a_coords[0]]

        unless position_index[1] + a_coords[1] < 0 || position_index[0] + a_coords[0] < 0

          if enemies.include?(square_being_looked_at)

            self.valid_moves << coords_to_square([position_index[1] + a_coords[1], position_index[0] + a_coords[0]])

          else
            if @last_piece_moved != nil
              if square_being_looked_at == "_"
                if @selected_piece == "♟︎"
                  if position_index[1] == 4
                    if @last_piece_moved.values.first == "♙"
                      square = coords_to_square([position_index[1] + a_coords[1], position_index[0] + a_coords[0]])
                      square_split = square.split("")
                      from_split = @last_piece_moved.keys.first.split("")
                      to_split = @last_piece_moved.keys.last.split("")

                      if from_split.first == square_split.first && to_split.first == square_split.first
                        if from_split.last == "2" && to_split.last == "4"
                          self.valid_moves << coords_to_square([position_index[1] + a_coords[1], position_index[0] + a_coords[0]])
                        end
                      end
                    end
                  end
                end
              end
              if square_being_looked_at == "_"
                if @selected_piece == "♙"
                  if position_index[1] == 3
                    if @last_piece_moved.values.first == "♟︎"
                      square = coords_to_square([position_index[1] + a_coords[1], position_index[0] + a_coords[0]])
                      square_split = square.split("")
                      from_split = @last_piece_moved.keys.first.split("")
                      to_split = @last_piece_moved.keys.last.split("")

                      if from_split.first == square_split.first && to_split.first == square_split.first
                        if from_split.last == "7" && to_split.last == "5"
                          self.valid_moves << coords_to_square([position_index[1] + a_coords[1], position_index[0] + a_coords[0]])
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    movement_coords.each do |coords|

      if self.board[position_index[1] + coords[1]][position_index[0] + coords[0]] == "_" # Adding the relative valid attack square index via 'coords'

        self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

      else

      end

      if @selected_piece == "♙" && position_index[1] != 6
        break
      end

      if @selected_piece == "♟︎" && position_index[1] != 1
        break
      end
    end
  end

  def knight_options(relative_coords)
    self.valid_moves = []
    relative_coords.each do |coords|
      enemies = self.white_pieces.include?(self.selected_piece) ? self.black_pieces : self.white_pieces
      if self.valid_squares.include?(coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]]))

        square_being_looked_at = self.board[position_index[1] + coords[1]][position_index[0] + coords[0]]

        if enemies.include?(square_being_looked_at) || square_being_looked_at == "_"

          self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

        end
      end
    end
  end

  def king_options(relative_coords)
    self.valid_moves = []
    relative_coords.each do |coords|
      enemies = self.white_pieces.include?(self.selected_piece) ? self.black_pieces : self.white_pieces
      if self.valid_squares.include?(coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]]))

        square_being_looked_at = self.board[position_index[1] + coords[1]][position_index[0] + coords[0]]

        if enemies.include?(square_being_looked_at) || square_being_looked_at == "_"

          self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

        end
      end
    end
    case @selected_piece
    when "♔"
      if self.white_king_check? == false && @has_moved[:white_a_rook] == "no" && @has_moved[:white_h_rook] == "no" && @has_moved[:white_king] ==  "no"
        #short castles O-O

        if @board[7][5] == "_" && @board[7][6] == "_"
          self.valid_moves << "O-O"

        end

        #long castles O-O-O
        if @board[7][3] == "_" && @board[7][2] == "_" && @board[7][1] == "_"
          self.valid_moves << "O-O-O"
        end
      end

    when "♚"
      if self.black_king_check? == false && @has_moved[:black_a_rook] == "no" && @has_moved[:black_h_rook] == "no" && @has_moved[:black_king] ==  "no"
        #short castles O-O
        if @board[0][5] == "_" && @board[0][6] == "_"
          self.valid_moves << "O-O"
        end

        #long castles O-O-O
        if @board[0][3] == "_" && @board[0][2] == "_" && @board[0][1] == "_"
          self.valid_moves << "O-O-O"
        end
      end
    end
  end

  def iterative_options(relative_coords)
    self.valid_moves = []
    relative_coords.each do |directions|
      directions.each do |coords|
        enemies = self.white_pieces.include?(self.selected_piece) ? self.black_pieces : self.white_pieces
        friends = self.white_pieces.include?(self.selected_piece) ? self.white_pieces : self.black_pieces
        if self.valid_squares.include?(coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]]))

          square_being_looked_at = self.board[position_index[1] + coords[1]][position_index[0] + coords[0]]

          if self.position_index[1] + coords[1] < 0 || self.position_index[0] + coords[0] < 0
            break
          end

          if square_being_looked_at == "_"

            self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

          elsif enemies.include?(square_being_looked_at)

            self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

            break

          elsif friends.include?(square_being_looked_at)

            break

          end

        end
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

  def white_king_check?(board = @board, white_king_position = @white_king_position)
    in_check = false

    friends = self.white_pieces

    Coordinates.white_pawn_attacks.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([white_king_position[0] + coords[1], white_king_position[0] + coords[1]]))

        square_being_looked_at = board[white_king_position[1] + coords[1]][white_king_position[0] + coords[0]]

        if %w[♟︎].include?(square_being_looked_at)
          # pp "found pawn check"
          in_check = true
          break
        end
      end
    end

    Coordinates.knight_moves.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([white_king_position[0] + coords[1], white_king_position[0] + coords[1]]))

        square_being_looked_at = board[white_king_position[0] + coords[1]][white_king_position[1] + coords[0]]

        if %w[♞].include?(square_being_looked_at)
          # pp "found knight check"
          in_check = true
          break
        end
      end
    end

    Coordinates.king_moves.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([white_king_position[0] + coords[1], white_king_position[0] + coords[1]]))

        square_being_looked_at = board[white_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

        if %w[♚].include?(square_being_looked_at)
          # pp "found king check"
          in_check = true
          break
        end
      end
    end

    Coordinates.rook_moves.each do |directions|
      break if in_check

      directions.each do |coords|
        if self.valid_squares.include?(coords_to_square([white_king_position[0] + coords[1], white_king_position[1] + coords[0]]))
          square_being_looked_at = board[white_king_position[0] + coords[1]][white_king_position[1] + coords[0]]

          unless white_king_position[0] + coords[1] < 0 || white_king_position[1] + coords[0] < 0

            if %w[♜ ♛].include?(square_being_looked_at)
              # pp "found rook/queen check"
              in_check = true
              break
            elsif friends.include?(square_being_looked_at) || %w[♟︎ ♞ ♝ ♚].include?(square_being_looked_at)
              break
            end
          end
        end
      end
    end

    Coordinates.bishop_moves.each do |directions|
      break if in_check

      directions.each do |coords|
        if self.valid_squares.include?(coords_to_square([white_king_position[0] + coords[1], white_king_position[1] + coords[0]]))
          square_being_looked_at = board[white_king_position[0] + coords[1]][white_king_position[1] + coords[0]]

          if white_king_position[0] + coords[1] < 0 || white_king_position[1] + coords[0] < 0
            break
          end

          if %w[♝ ♛].include?(square_being_looked_at)
            # pp "found bishop/queen check"
            in_check = true
            break
          elsif friends.include?(square_being_looked_at) || %w[♟︎ ♞ ♜ ♚].include?(square_being_looked_at)
            break
          end
        end
      end
    end
    in_check
  end

  def black_king_check?(board = @board, black_king_position = @black_king_position)
    in_check = false

    friends = self.black_pieces

    Coordinates.black_pawn_attacks.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([black_king_position[0] + coords[1], black_king_position[0] + coords[1]]))

        square_being_looked_at = board[black_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

        if %w[♙].include?(square_being_looked_at)
          # pp "found pawn check"
          in_check = true
          break
        end
      end
    end

    Coordinates.knight_moves.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([black_king_position[0] + coords[1], black_king_position[0] + coords[1]]))

        square_being_looked_at = board[black_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

        if %w[♘].include?(square_being_looked_at)
          # pp "found knight check"
          in_check = true
          break
        end
      end
    end

    Coordinates.king_moves.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([black_king_position[0] + coords[1], black_king_position[0] + coords[1]]))

        square_being_looked_at = board[black_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

        if %w[♔].include?(square_being_looked_at)
          # pp "found king check"
          in_check = true
          break
        end
      end
    end

    Coordinates.rook_moves.each do |directions|
      break if in_check

      directions.each do |coords|
        if self.valid_squares.include?(coords_to_square([black_king_position[0] + coords[1], black_king_position[1] + coords[0]]))
          square_being_looked_at = board[black_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

          unless black_king_position[0] + coords[1] < 0 || black_king_position[1] + coords[0] < 0
            if %w[♖ ♕].include?(square_being_looked_at)
              # pp "found rook/queen check"
              in_check = true
              break
            elsif friends.include?(square_being_looked_at) || %w[♙ ♘ ♗ ♔].include?(square_being_looked_at)
              break
            end
          end
        end
      end
    end

    Coordinates.bishop_moves.each do |directions|
      break if in_check

      directions.each do |coords|
        if self.valid_squares.include?(coords_to_square([black_king_position[0] + coords[1], black_king_position[1] + coords[0]]))
          square_being_looked_at = board[black_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

          if black_king_position[0] + coords[1] < 0 || black_king_position[1] + coords[0] < 0
            break
          end

          if %w[♗ ♕].include?(square_being_looked_at)
            # pp "found bishop/queen check"
            in_check = true
            break
          elsif friends.include?(square_being_looked_at) || %w[♙ ♘ ♖ ♔].include?(square_being_looked_at)
            break
          end
        end
      end
    end

    in_check
  end

  def check_valid_moves(valid_moves = @valid_moves, selected_piece = @selected_piece)
    moves_to_check = Marshal.load(Marshal.dump(valid_moves))
    moves_to_check.each do |move|

      if move == "O-O" || move == "O-O-O"
        next
      end

      move_index = move.split("")

      move_index[0] = self.letters_to_coords.find_index(move_index[0])

      move_index[1] = 8 - move_index[1].to_i

      board_copy = Marshal.load(Marshal.dump(@board))

      board_copy[move_index[1]][move_index[0]] = selected_piece

      board_copy[position_index[1]][position_index[0]] = "_"

      case selected_piece

      when "♔"
        white_king_position_copy = Marshal.load(Marshal.dump(@white_king_position))
        white_king_position_copy[0] = move_index[1]
        white_king_position_copy[1] = move_index[0]
        if white_king_check?(board_copy, white_king_position_copy)
          @valid_moves.delete(move)
        end
      when "♚"
        black_king_position_copy = Marshal.load(Marshal.dump(@black_king_position))
        black_king_position_copy[0] = move_index[1]
        black_king_position_copy[1] = move_index[0]
        if black_king_check?(board_copy, black_king_position_copy)
          @valid_moves.delete(move)
        end
      end

      if @white_pieces.include?(@selected_piece)
        if white_king_check?(board_copy)
          @valid_moves.delete(move)
        end
      end

      if @black_pieces.include?(@selected_piece)
        if black_king_check?(board_copy)
          @valid_moves.delete(move)
        end
      end
    end
  end

  def update_last_piece_moved(selected_piece, answer, position_index)
    @last_piece_moved = {}
    @last_piece_moved[position] = selected_piece  #from
    @last_piece_moved[answer] = selected_piece    #to
  end

  def make_move
    answer = gets.chomp
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

      when "♚"
        @board[0][4] = "_"
        @board[0][6] = "♚"
        @board[0][7] = "_"
        @board[0][5] = "♜"

      end
    elsif answer == "O-O-O"
      case @selected_piece
      when "♔"
        @board[7][4] = "_"
        @board[7][2] = "♔"
        @board[7][0] = "_"
        @board[7][3] = "♖"
      when "♚"
        @board[0][4] = "_"
        @board[0][2] = "♚"
        @board[0][0] = "_"
        @board[0][3] = "♜"
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

  def promotion(colour, file)

    puts "Choose which piece to promote your pawn to [Queen / Rook / Knight / Bishop]"

    answer = gets.chomp

    promotion_pieces = %w[queen rook knight bishop]

    white_promotions = {"queen" => "♕", "rook" => "♖", "knight" => "♘", "bishop" => "♗"}

    black_promotions = {"queen" => "♛", "rook" => "♜", "knight" => "♞", "bishop" => "♝"}


    unless promotion_pieces.include?(answer.downcase)
      puts "Must pick a valid piece"
      return self.promotion
    end

    case @to_play
    when "white"

      @board[0][file] = white_promotions[answer.to_s]
      @board[position_index[1]][position_index[0]] = "_"
    when "black"
      @board[7][file] = black_promotions[answer.to_s]
      @board[position_index[1]][position_index[0]] = "_"
    end
  end

  def fetch_piece_positions
    @board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        friends = @to_play == "white" ? @white_pieces : @black_pieces
        if friends.include?(column)
          @piece_positions[self.coords_to_square([row_index, column_index])] = column
        end
      end
    end
  end

  def checkmate?
    friends = @to_play == "white" ? @white_pieces : @black_pieces
    self.fetch_piece_positions
    pieces_with_legal_moves = []
    @piece_positions.each do |key, value|

      if friends.include?(value)
       self.identify_piece(key)
       self.check_valid_moves

       if @valid_moves.any?
          pieces_with_legal_moves << key
       end

      end
    end

    if pieces_with_legal_moves.empty?
      return true

    else
      return false
    end
  end

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

    if @to_play == "white"
      @to_play = "black"
    elsif @to_play == "black"
      @turn += 1
      @to_play = "white"
    end
    self.play_game
  end

  def save_game
    puts "What would you like to call the saved game?"
    game_name = gets.chomp.downcase
    game_hash =
    {board: @board,
     turn: @turn,
     to_play: @to_play,
     last_piece_moved: @last_piece_moved,
     has_moved: @has_moved,
     white_king_position: @white_king_position,
     black_king_position: @black_king_position }
    serialized_game = YAML::dump(game_hash)
    File.write("saves/#{game_name}.yaml", serialized_game)
    puts "Game saved successfully as #{game_name}.yaml"
    exit
  end
end

def new_game_or_load
  puts "Would you like to start a new game, or load one? [new / load]"
  answer = gets.chomp
  unless answer.downcase == 'new' || answer.downcase == 'load'
    return self.new_game_or_load
  end
  case answer.downcase
  when 'new'
    game = Chess.new
    game.play_game
  when 'load'
    self.load_game
  end
end

def load_game
  puts Dir.entries("saves")
  save_files =[]
  save_files << Dir.entries("saves")
  pp save_files
  puts "Please pick a game to load"
  response = gets.chomp
  serialized_game = File.open("saves/#{response}", "r")
  unserialized_game = YAML::load_file(serialized_game)
  loaded_game = Chess.new(unserialized_game[:board], unserialized_game[:turn], unserialized_game[:to_play], unserialized_game[:last_piece_moved], unserialized_game[:has_moved], unserialized_game[:white_king_position], unserialized_game[:black_king_position])
  loaded_game.play_game
rescue Errno::ENOENT
  self.load_game
end

new_game_or_load()
