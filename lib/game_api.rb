require 'json'
require 'rack/response'

module GameApi
  # This to become our GameApi application
  class Router
    def call(env)
      request = Rack::Request.new(env)

      app = case request.path
            when %r{\/games\/create} then GamesController.new
            end

      app.call(env)
    end
  end

  # GameApi::Create handles creation of games
  class GamesController
    def call(_env)
      response = Rack::Response.new
      response.write({ id: 1 }.to_json)
      response.finish
    end
  end
end
