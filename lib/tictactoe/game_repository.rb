require 'securerandom'

module Tictactoe
  # GameRepository is the storage layer for games
  class GameRepository
    class << self
      attr_accessor :games
    end
    @games = {}

    def self.create
      uuid = SecureRandom.uuid
      @games[uuid] = Game.new(id: uuid)
    end

    def self.find(id)
      @games[id]
    end
  end
end
