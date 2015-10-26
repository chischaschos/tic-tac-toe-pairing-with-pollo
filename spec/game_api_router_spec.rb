require 'rack/test'
require_relative '../lib/game_api'

describe GameApi::Router do
  include Rack::Test::Methods

  def app
    GameApi::Router.new
  end

  describe 'creates a game' do
    it 'success' do
      post '/games/create'
      expect(last_response).to be_ok
    end
  end

  xdescribe 'creates moves in a game ' do
    let(:game) { double('GameD', id: 1) }

    it 'success' do
      post "/games/#{game.id}/moves", x: 1, y: 1
      expect(last_response).to be_ok
    end
  end
end
