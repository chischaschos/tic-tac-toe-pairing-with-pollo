require 'rspec/collection_matchers'

class Player

end

class CoreGame

  attr_reader :board

  def initialize
    @players = [ Player.new, Player.new ]
    @board = [Array.new(3, ''), Array.new(3, ''), Array.new(3, '')]
  end

  def move(x, y)
    symbol = @board.flatten.select{|item| item != ''}.length.odd? ? 'O' : 'X'
    @board[x][y] = symbol
  end

  def state
    return 'unstarted' if @board.flatten.select{|item| item != ''}.count == 0
    return 'on-progress' if @board.flatten.select{|item| item != ''}.count > 0
    return 'finished'
  end
end

describe CoreGame do
  subject(:game) { CoreGame.new }

  let(:x_winning_movements) do
    [
       [0, 0],
       [0, 1],
       [1, 1],
       [1, 2],
     ]
  end

  it 'plays a full tic tac toe game' do
    expect(game.state).to eq 'unstarted'

    x_winning_movements.each do |coords|
      game.move(*coords)
      expect(game.state).to eq 'on-progress'
    end

    expect(game.board).to eq ([
      ['X', 'O', ''],
      ['', 'X', 'O'],
      ['', '', ''],
    ])

    game.move(2, 2)
    expect(game.state).to eq 'finished'
    expect(game.winner).to eq 'X'
  end

  describe '#board' do
    it 'tracks the movement on 0, 0' do
      game.move(0, 0)
      expect(game.board).to eq ([
        ['X', '', ''],
        ['', '', ''],
        ['', '', ''],
      ])
    end

    it 'tracks the movement on 0, 1' do
      game.move(0, 1)
      expect(game.board).to eq ([
        ['', 'X', ''],
        ['', '', ''],
        ['', '', ''],
      ])
    end

    it "the first movement can't be an O" do
      game.move(0, 1)
      expect(game.board).to_not eq ([
        ['', 'O', ''],
        ['', '', ''],
        ['', '', ''],
      ])
    end

    it "odd movements are tracked as O" do
      game.move(0, 1)
      game.move(0, 2)
      expect(game.board).to eq ([
        ['', 'X', 'O'],
        ['', '', ''],
        ['', '', ''],
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

  xit 'should not allow a player to move twice'
end
