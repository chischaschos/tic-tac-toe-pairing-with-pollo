module Tictactoe
  # Game is the persisted representation of a tictactoe game
  class Game
    attr_reader :id

    def initialize(id: nil)
      @id = id
    end
  end
end
