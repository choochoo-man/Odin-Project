module SaveLoad
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
end
