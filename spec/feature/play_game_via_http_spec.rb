require 'rest_client'
require 'rack'
require_relative '../../lib/game_api'

describe 'Play game via http' do
  let(:server_url) { 'localhost:9292' }

  before do
    @pid = fork do
      Rack::Server.start(
        app: GameApi.new,
        daemonize: true,
        server: 'webrick'
      )
    end
  end

  after do
    `kill -9 #{@pid}`
  end

  it 'a user plays a game' do
    # response = RestClient.post(server_url + '/games/create', {})

    # new_game_response = JSON.parse(response)
  end
end
