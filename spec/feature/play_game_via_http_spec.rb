require 'rest_client'

xdescribe 'Play game via http' do
  let(:server_url) { 'localhost:9292' }

  before do
    Rack::Server.start do
      puts options
      options['daemonize']
    end
  end

  it 'a user plays a game' do
    # response = RestClient.post(server_url + '/games/create', {})

    # new_game_response = JSON.parse(response)
  end
end
