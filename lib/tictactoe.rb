# Tictactoe is application that serves tictactoe games through a restful api
module Tictactoe
  autoload :CoreGame,       'tictactoe/core_game'
  autoload :Game,           'tictactoe/game'
  autoload :GameApi,        'tictactoe/game_api'
  autoload :GameRepository, 'tictactoe/game_repository'
end
