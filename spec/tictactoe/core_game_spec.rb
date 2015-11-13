require 'spec_helper'

describe Tictactoe::CoreGame do
  subject(:game) { Tictactoe::CoreGame.new }

  let(:x_winning_movements) do
    [
      [0, 0],
      [0, 1],
      [1, 1],
      [1, 2]
    ]
  end

  let(:o_winning_movements) do
    [
      [0, 1],
      [0, 0],
      [1, 2],
      [1, 1],
      [2, 1]
    ]
  end

  describe 'full game' do
    it 'O wins a tic tac toe game' do
      expect(game.state).to eq 'unstarted'

      o_winning_movements.each do |coords|
        game.move(*coords)
        expect(game.state).to eq 'on-progress'
      end

      expect(game.board).to eq([
        ['O', 'X', ''],
        ['', 'O', 'X'],
        ['', 'X', '']
      ])

      game.move(2, 2)
      expect(game.state).to eq 'finished'
      expect(game.winner).to eq 'O'
    end

    it 'X wins a tic tac toe game' do
      expect(game.state).to eq 'unstarted'

      x_winning_movements.each do |coords|
        game.move(*coords)
        expect(game.state).to eq 'on-progress'
      end

      expect(game.board).to eq([
        ['X', 'O', ''],
        ['', 'X', 'O'],
        ['', '', '']
      ])

      game.move(2, 2)
      expect(game.state).to eq 'finished'
      expect(game.winner).to eq 'X'
    end
  end

  describe '#board' do
    it 'tracks the movement on 0, 0' do
      game.move(0, 0)
      expect(game.board).to eq([
        ['X', '', ''],
        ['', '', ''],
        ['', '', '']
      ])
    end

    it 'tracks the movement on 0, 1' do
      game.move(0, 1)
      expect(game.board).to eq([
        ['', 'X', ''],
        ['', '', ''],
        ['', '', '']
      ])
    end

    it "the first movement can't be an O" do
      game.move(0, 1)
      expect(game.board).to_not eq([
        ['', 'O', ''],
        ['', '', ''],
        ['', '', '']
      ])
    end

    it 'odd movements are tracked as O' do
      game.move(0, 1)
      game.move(0, 2)
      expect(game.board).to eq([
        ['', 'X', 'O'],
        ['', '', ''],
        ['', '', '']
      ])
    end
  end

  describe '#winner' do
    it "does not have a winner when the game hasn't started" do
      expect(game.winner).to eq nil
    end

    it 'does not have winner when the game is on progress' do
      game.move(1, 1)
      expect(game.winner).to eq nil
    end

    it 'does have a winner when the game is finished' do
      x_winning_movements.each do |coords|
        game.move(*coords)
      end

      game.move(2, 2)
      expect(game.winner).to eq 'X'
    end
  end

  describe '#state' do
    it "has a different state when the game hasn't started" do
      expect(game.state).to eq 'unstarted'
    end

    it 'changes the state fo the board after a movement' do
      game.move(1, 1)
      expect(game.state).to eq 'on-progress'
    end

    it 'determines when the game is finished' do
      x_winning_movements.each do |coords|
        game.move(*coords)
      end

      game.move(2, 2)

      expect(game.state).to eq 'finished'
    end
  end

  describe '#finished?' do
    context 'when winning by completing a row' do
      let(:movements) do
        [
          [0, 0],
          [1, 0],
          [0, 1],
          [1, 1],
          [0, 2]
        ]
      end

      it 'has a finished state' do
        movements.each do |coords|
          game.move(*coords)
        end

        expect(game).to be_finished
      end
    end

    context 'when winning by completing a column' do
      let(:movements) do
        [
          [0, 0],
          [0, 1],
          [1, 0],
          [1, 1],
          [2, 0]
        ]
      end

      it 'has a finished state' do
        movements.each do |coords|
          game.move(*coords)
        end

        expect(game).to be_finished
      end
    end

    context 'when winning by completing a diagonal' do
      let(:movements) do
        [
          [0, 0],
          [0, 1],
          [1, 1],
          [1, 2],
          [2, 2]
        ]
      end

      it 'has a finished state' do
        movements.each do |coords|
          game.move(*coords)
        end

        expect(game).to be_finished
      end
    end
  end

  context 'when winning by completing an inverse diagonal' do
    let(:movements) do
      [
        [0, 2],
        [0, 1],
        [1, 1],
        [1, 2],
        [2, 0]
      ]
    end

    it 'has a finished state' do
      movements.each do |coords|
        game.move(*coords)
      end

      expect(game).to be_finished
    end
  end

  xit 'should not allow a player to move twice'
end
