module Knight
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
end
