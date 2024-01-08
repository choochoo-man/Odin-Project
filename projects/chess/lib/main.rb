# White pieces: Pawn: ♙, Knight: ♘, Bishop: ♗, Rook: ♖, Queen: ♕, King: ♔
# Black pieces: Pawn: ♟︎, Knight: ♞, Bishop: ♝, Rook: ♜, Queen: ♛, King: ♚


class Chess
  attr_accessor :board, :valid_squares, :position, :position_index, :white_pieces, :black_pieces, :valid_moves, :letters_to_coords, :selected_piece, :white_king_position, :black_king_position
  def initialize(board = Array.new(4) {Array.new(8, "_")}, valid_squares = [], position = nil, position_index = nil, valid_moves = [], selected_piece = nil)
    @board = board
    @valid_squares = valid_squares
    @position = position
    @position_index = position_index
    @white_pieces = %w[♙ ♘ ♗ ♖ ♕ ♔]
    @black_pieces = %w[♟︎ ♞ ♝ ♜ ♛ ♚]
    @valid_moves = valid_moves
    @letters_to_coords = %w[a b c d e f g h]
    @selected_piece = selected_piece
    @white_king_position = [7, 4]
    @black_king_position = [0, 4]

    @board << %w[♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙]
    @board << %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖]
    @board.unshift(%w[♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎])
    @board.unshift(%w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜])

    ("a".."h").each do |letter|
      (1..8).each do |number|
        @valid_squares << "#{letter}#{number}"

      end
    end
  end

  def choose_square
    puts "Please choose a piece to move (a1 - h8)"
    answer = gets.chomp

    unless @valid_squares.include?(answer)
      return choose_square

    end

    if @valid_squares.include?(answer)
      self.position = answer

    end
  end

  def identify_piece
    @position_index = @position.split("")

    @position_index[0] = self.letters_to_coords.find_index(position_index[0])

    @position_index[1] = 8 - position_index[1].to_i

    @selected_piece = self.board[position_index[1]][position_index[0]]

    case selected_piece
    when "♙"
      self.white_pawn
    when "♟︎"
      self.black_pawn
    when "♘" || "♞"
      self.knight 
    when "♗" || "♝"
      self.bishop
    when "♖" || "♜"
      self.rook
    when "♕" || "♛"
      self.queen
    when "♔"
      self.white_king
    when "♚"
      self.black_king
    else
      puts "Must choose a piece to move"
      return self.choose_square

    end 
  end

  def coords_to_square(coords)
    return "#{self.letters_to_coords[coords[1]]}" + "#{8 - coords[0]}"
  end



  def pawn_options(movement_coords, attack_coords)
    self.valid_moves = []

    movement_coords.each do |coords|

      if self.board[position_index[1] + coords[1]][position_index[0] + coords[0]] == "_" # Adding the relative valid attack square index via 'coords'

        self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

      else
        break
      end
    end

    attack_coords.each do |coords|
     enemies = self.white_pieces.include?(self.selected_piece) ? self.black_pieces : self.white_pieces

    square_being_looked_at = self.board[position_index[1] + coords[1]][position_index[0] + coords[0]]
      if enemies.include?(square_being_looked_at)

        self.valid_moves << coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]])

      end
    end
    if @valid_moves.empty?
      puts "No legal moves for this piece"
      return self.choose_square
    end
    pp @valid_moves
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
    if @valid_moves.empty?
      puts "No legal moves for this piece"
      return self.choose_square
    end
    pp @valid_moves
  end

  def iterative_options(relative_coords)
    self.valid_moves = []
    relative_coords.each do |directions|
      directions.each do |coords|
        enemies = self.white_pieces.include?(self.selected_piece) ? self.black_pieces : self.white_pieces
        friends = self.white_pieces.include?(self.selected_piece) ? self.white_pieces : self.black_pieces
        if self.valid_squares.include?(coords_to_square([position_index[1] + coords[1], position_index[0] + coords[0]]))

          square_being_looked_at = self.board[position_index[1] + coords[1]][position_index[0] + coords[0]]

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
    if @valid_moves.empty?
      puts "No legal moves for this piece"
      return self.choose_square
    end
    pp @valid_moves
  end


  def white_pawn
    puts "Here are the moves your pawn can make"
      movement_coords = [[0, -1],[0, -2]]

      attack_coords = [[-1, -1],[1, -1]]

      pawn_options(movement_coords, attack_coords)

  end

  def bishop
    puts "Here are the moves your bishop can make:"
    relative_coords = [
      [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]],
      [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]]
    iterative_options(relative_coords)
  end

  def knight
    puts "Here are the moves your knight can make"
    relative_coords = [[-1, -2], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1]]

    knight_options(relative_coords)

  end

  def rook
    puts "Here are the moves your rook can make:"
    relative_coords = [
      [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]]]
    iterative_options(relative_coords)
  end

  def queen
    puts "Here are the moves your queen can make:"
    relative_coords = [
      [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]],
      [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]],
      [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]]
  end

  def white_king
    "Here are the moves your king can make:"
  end

  def black_pawn
    puts "Here are the moves your black pawn can make:"
    movement_coords = [[0, 1],[0, 2]]

    attack_coords = [[-1, 1],[1, 1]]

    pawn_options(movement_coords, attack_coords)
  end

  def black_king
    "Here are the moves your king can make:"
  end

  def white_king_check?
    in_check = false
    enemies = self.black_pieces
    friends = self.white_pieces
    queen_moves = [
      [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]],
      [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]],
      [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]]
    knight_moves = [[-1, -2], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1]]

    knight_moves.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([self.white_king_position[0] + coords[1], self.white_king_position[0] + coords[1]]))

        square_being_looked_at = self.board[self.white_king_position[0] + coords[1]][self.white_king_position[1] + coords[0]]

        if enemies.include?(square_being_looked_at)
          in_check = true
          break
        end
      end
    end

    queen_moves.each do |directions|
      break if in_check

      directions.each do |coords|
        if self.valid_squares.include?(coords_to_square([self.white_king_position[0] + coords[1], self.white_king_position[1] + coords[0]]))
          square_being_looked_at = self.board[self.white_king_position[0] + coords[1]][self.white_king_position[1] + coords[0]]

          if enemies.include?(square_being_looked_at)
            in_check = true
            break
          elsif friends.include?(square_being_looked_at)
            break
          end
        end
      end
    end
    in_check
  end

  def black_king_check?
    in_check = false
    enemies = self.white_pieces
    friends = self.black_pieces
    queen_moves = [
      [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]],
      [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]],
      [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]]]
    knight_moves = [[-1, -2], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1]]

    knight_moves.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([self.black_king_position[0] + coords[1], self.black_king_position[0] + coords[1]]))

        square_being_looked_at = self.board[self.black_king_position[0] + coords[1]][self.black_king_position[1] + coords[0]]

        if enemies.include?(square_being_looked_at)
          in_check = true
          break
        end
      end
    end

    queen_moves.each do |directions|
      break if in_check

      directions.each do |coords|
        if self.valid_squares.include?(coords_to_square([self.black_king_position[0] + coords[1], self.black_king_position[1] + coords[0]]))
          square_being_looked_at = self.board[self.black_king_position[0] + coords[1]][self.black_king_position[1] + coords[0]]

          if enemies.include?(square_being_looked_at)
            in_check = true
            break
          elsif friends.include?(square_being_looked_at)
            break
          end
        end
      end
    end
    in_check
  end


end

game = Chess.new
game.board[5][0] = "♟︎"
game.board[5][2] = "♙"
game.board[5][0] = "♙"
game.board[5][3] = "♞"
pp game.board
pp game.white_king_check?
pp game.board
game.choose_square
game.identify_piece
