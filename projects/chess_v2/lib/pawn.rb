module Pawn
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
end
