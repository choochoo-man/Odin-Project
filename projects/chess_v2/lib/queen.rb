module Queen
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
end
