require 'rack/test'
require_relative '../lib/game_api'

describe GameApi do
  include Rack::Test::Methods

  def app
    GameApi.new
  end

  describe 'creates a game' do
    it 'success' do
      post '/new'
      expect(last_response).to be_ok
    end
  end
end
