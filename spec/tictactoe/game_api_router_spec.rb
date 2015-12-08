require 'spec_helper'
require 'rack/test'

describe Tictactoe::GameApi::Router do
  include Rack::Test::Methods

  def app
    Tictactoe::GameApi::Router.new
  end

  describe 'games endpoint' do
    describe 'post /games' do
      it 'success' do
        post '/games/create'
        expect(last_response).to be_ok
      end

      it 'returns a game id' do
        post '/games/create'
        response_body = JSON.parse(last_response.body)
        expect(response_body['id']).to be_an(Integer)
      end
    end

    describe 'get /games/:id' do
      xit 'returns an existing game'
    end
  end

  describe 'creates moves in a game ' do
    let(:game) { Tictactoe::Game.new(id: 1) }

    let(:result_board) do
      {
        'board' => [
          ['', '', ''],
          ['', 'X', ''],
          ['', '', '']
        ]
      }
    end

    before { post "/games/#{game.id}/moves", x: 1, y: 1 }

    it 'success' do
      expect(last_response).to be_ok
    end

    it "returns the current game's state" do
      response_body = JSON.parse(last_response.body)
      expect(response_body).to eq(result_board)
    end
  end
end
