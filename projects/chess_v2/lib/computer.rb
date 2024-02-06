module Computer
  def random_computer_move
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
      @position = pieces_with_legal_moves.sample
      self.identify_piece
      random_move = @valid_moves.sample
      self.make_move(random_move)
    end

    def play_computer
      if @computer == 'white' && @to_play == 'white'
          puts "Computer is making a move"
          self.random_computer_move
          puts "Moved #{@last_piece_moved.values.first} from square #{@last_piece_moved.keys.first} to square #{@last_piece_moved.keys.last}"

      elsif @computer == 'black' && @to_play == 'black'
        puts "Computer is making a move"
        self.random_computer_move
        puts "Moved #{@last_piece_moved.values.first} from square #{@last_piece_moved.keys.first} to square #{@last_piece_moved.keys.last}"
      end
    end
  end
end
