class Checkmate
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
end
