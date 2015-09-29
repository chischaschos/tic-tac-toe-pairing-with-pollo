require 'rspec/collection_matchers'

class Player

end

class CoreGame

  attr_reader :movements

  def initialize
    @players = [ Player.new, Player.new ]
    @movements = []
  end

  def move(x, y)
    @movements << [x,y]
  end

end

describe CoreGame do
  subject(:game) { CoreGame.new }

  it 'allows players to make movements' do
    game.move(0, 0)
    game.move(0, 1)

    expect(game.movements).to have(2).items
    expect(game.movements.last).to eq([0, 1])
  end

  xit 'should not allow a player to move twice'
end
