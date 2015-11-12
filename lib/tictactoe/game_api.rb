require 'json'
require 'rack/response'

module Tictactoe
  module GameApi
    # This to become our GameApi application
    class Router
      def call(env)
        request = Rack::Request.new(env)

        app = case request.path
              when %r{\/games\/create} then GamesController.new
              when %r{\/games\/\d+\/moves} then GameMovesController.new
              end

        app.call(env)
      end
    end

    # GamesController handles creation of games
    class GamesController
      def call(_env)
        response = Rack::Response.new
        response.write({ id: 1 }.to_json)
        response.finish
      end
    end

    # GameMovesController handles the creation of movements in a specific game
    class GameMovesController
      def call(_env)
        response = Rack::Response.new
        board = [
          ['', '', ''],
          ['', 'X', ''],
          ['', '', '']
        ]
        response.write({ board: board }.to_json)
        response.finish
      end
    end
  end
end
