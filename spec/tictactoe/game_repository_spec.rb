require 'spec_helper'

describe Tictactoe::GameRepository do
  describe '.create' do
    it 'stores a game reference' do
      game = Tictactoe::GameRepository.create

      expect(game).to be_a(Tictactoe::Game)
      expect(game.id).not_to be_nil
    end

    it 'generates unique ids per game' do
      games = 3.times.map { Tictactoe::GameRepository.create }

      ids = games.map(&:id).uniq

      expect(ids).to have(3).items
    end
  end

  describe '.find' do
    it 'finds an existing game' do
      created_game = Tictactoe::GameRepository.create

      game = Tictactoe::GameRepository.find(created_game.id)

      expect(game).to eq(created_game)
    end
  end
end
