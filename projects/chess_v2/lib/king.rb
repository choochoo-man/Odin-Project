module King
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

        if @board[7][5] == "_" && @board[7][6] == "_"
          if check_castling_valid?("O-O")
            self.valid_moves << "O-O"
          end

        end

        if @board[7][3] == "_" && @board[7][2] == "_" && @board[7][1] == "_"
          if check_castling_valid?("O-O-O")
            self.valid_moves << "O-O-O"
          end
        end
      end

    when "♚"
      if self.black_king_check? == false && @has_moved[:black_a_rook] == "no" && @has_moved[:black_h_rook] == "no" && @has_moved[:black_king] ==  "no"
        if @board[0][5] == "_" && @board[0][6] == "_"
          if check_castling_valid?("O-O")
            self.valid_moves << "O-O"
          end
        end

        if @board[0][3] == "_" && @board[0][2] == "_" && @board[0][1] == "_"
          if check_castling_valid?("O-O-O")
            self.valid_moves << "O-O-O"
          end
        end
      end
    end
  end

  def white_king_check?(board = @board, white_king_position = @white_king_position)
    in_check = false

    friends = self.white_pieces

    Coordinates.white_pawn_attacks.each do |coords|
      break if in_check

      if self.valid_squares.include?(coords_to_square([white_king_position[0] + coords[1], white_king_position[1] + coords[0]]))

        square_being_looked_at = board[white_king_position[0] + coords[1]][white_king_position[1] + coords[0]]

        if %w[♟︎].include?(square_being_looked_at)

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

      if self.valid_squares.include?(coords_to_square([black_king_position[0] + coords[1], black_king_position[1] + coords[0]]))

        square_being_looked_at = board[black_king_position[0] + coords[1]][black_king_position[1] + coords[0]]

        if %w[♙].include?(square_being_looked_at)

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

  def check_castling_valid?(direction)
    board_copy = Marshal.load(Marshal.dump(@board))
    case @selected_piece
    when "♔"
      white_king_position_copy = Marshal.load(Marshal.dump(@white_king_position))
      case direction
      when "O-O"
        board_copy[7][4] = "_"
        board_copy[7][5] = "♔"
        white_king_position_copy = [7, 5]

        if white_king_check?(board_copy, white_king_position_copy)
          return false

        else
          board_copy[7][5] = "_"
          board_copy[7][6] = "♔"
          white_king_position_copy = [7, 6]
          if white_king_check?(board_copy, white_king_position_copy)
            return false
          else
            return true
          end
        end
      when "O-O-O"
        board_copy[7][4] = "_"
        board_copy[7][3] = "♔"
        white_king_position_copy = [7, 3]

        if white_king_check?(board_copy, white_king_position_copy)
          return false

        else
          board_copy[7][3] = "_"
          board_copy[7][2] = "♔"
          white_king_position_copy = [7, 2]
          if white_king_check?(board_copy, white_king_position_copy)
            return false
          else
            return true
          end
        end
      end
    when "♚"
      black_king_position_copy = Marshal.load(Marshal.dump(@black_king_position))
      case direction
      when "O-O"
        board_copy[0][4] = "_"
        board_copy[0][5] = "♔"
        black_king_position_copy = [0, 5]

        if black_king_check?(board_copy, black_king_position_copy)
          return false

        else
          board_copy[0][5] = "_"
          board_copy[0][6] = "♔"
          black_king_position_copy = [0, 6]
          if black_king_check?(board_copy, black_king_position_copy)
            return false
          else
            return true
          end
        end

      when "O-O-O"
        board_copy[0][4] = "_"
        board_copy[0][3] = "♔"
        black_king_position_copy = [0, 3]

        if black_king_check?(board_copy, black_king_position_copy)
          return false

        else
          board_copy[0][3] = "_"
          board_copy[0][2] = "♔"
          black_king_position_copy = [0, 2]
          if black_king_check?(board_copy, black_king_position_copy)
            return false
          else
            return true
          end
        end
      end
    end
  end
end
