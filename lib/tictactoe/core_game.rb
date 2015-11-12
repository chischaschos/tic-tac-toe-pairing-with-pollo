module Tictactoe
  # Game mechanism for playing tic tac toe
  class CoreGame
    attr_reader :board, :winner

    def initialize
      @board = [Array.new(3, ''), Array.new(3, ''), Array.new(3, '')]
    end

    def move(x, y)
      symbol = @board.flatten.count { |item| item != '' }.odd? ? 'O' : 'X'
      @board[x][y] = symbol
      @winner = symbol if finished?
    end

    def state
      return 'unstarted' if @board.flatten.count { |item| item != '' } == 0
      if finished?
        return 'finished'
      else
        return 'on-progress'
      end
    end

    def finished?
      combinations = diagonal_combinations + row_combinations
      combinations.find { |row| similar_in_row?(row) }
    end

    private

    def similar_in_row?(row)
      symbols = %w( O X )
      row.uniq.length == 1 && symbols.include?(row.first)
    end

    def diagonal_combinations
      [
        [@board[0][0], @board[1][1], @board[2][2]],
        [@board[2][0], @board[1][1], @board[0][2]]
      ]
    end

    def row_combinations
      combinations = []

      [@board, @board.transpose].each do |tmp_board|
        2.downto(0) do |i|
          combinations << tmp_board[i]
        end
      end

      combinations
    end
  end
end
