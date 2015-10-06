require 'rspec/collection_matchers'

# Game mechanism for playing tic tac toe
class CoreGame
  attr_reader :board

  def initialize
    @board = [Array.new(3, ''), Array.new(3, ''), Array.new(3, '')]
  end

  def move(x, y)
    symbol = @board.flatten.count { |item| item != '' }.odd? ? 'O' : 'X'
    @board[x][y] = symbol
  end

  def state
    return 'unstarted' if @board.flatten.count { |item| item != '' } == 0
    if finished?
      return 'finished'
    else
      return 'on-progress'
    end
  end

  def finished?
    combinations = diagonal_combinations + row_combinations
    combinations.find { |row| similar_in_row?(row) }
  end

  def winner
    'X'
  end

  private

  def similar_in_row?(row)
    symbols = %w( O X )
    row.uniq.length == 1 && symbols.include?(row.first)
  end

  def diagonal_combinations
    [
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[2][0], @board[1][1], @board[0][2]]
    ]
  end

  def row_combinations
    combinations = []

    [@board, @board.transpose].each do |tmp_board|
      2.downto(0) do |i|
        combinations << tmp_board[i]
      end
    end

    combinations
  end
end

describe CoreGame do
  subject(:game) { CoreGame.new }

  let(:x_winning_movements) do
    [
      [0, 0],
      [0, 1],
      [1, 1],
      [1, 2]
    ]
  end

  it 'plays a full tic tac toe game' do
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
