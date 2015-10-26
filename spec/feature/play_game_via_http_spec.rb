require 'rest_client'
require 'rack'
require_relative '../../lib/game_api'

describe 'Play game via http' do
  let(:server_url) { 'localhost:8080' }

  before do
    @pid = fork do
      Rack::Server.start(
        app: GameApi::Router.new,
        server: 'webrick'
      )
    end
    sleep 1
  end

  after do
    `kill -9 #{@pid}`
  end

  describe 'ping tests' do
    it 'creates games'

    it 'creates movements'

    it 'has a root page'

    it '500 on unexisting pages'
  end

  it 'a user plays a game' do
    # Start the game
    response = RestClient.post(server_url + '/games/create', {})
    new_game_response = JSON.parse(response)
    expect(new_game_response['id']).to be_an(Integer)

    # game_id = new_game_response['id']
    # url = server_url + "/games/#{game_id}/moves"
    # response = RestClient.post(url, {x: 1, y:1})
    # new_game_response = JSON.parse(response)
    # board = [
    # ['', '', ''],
    # ['', 'X', ''],
    # ['', '', '']
    # ]
    # expect(new_game_response[:board]).to eq(board)
  end
end
