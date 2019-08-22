# frozen_string_literal: false

class GameState
  def initialize
    @board = [0, 0, 0,
              0, 0, 0,
              0, 0, 0]
  end

  # Will determine if it's a winning state

  def winner?
    b = GameState.bin_converter(@board)
    @@WINNER_STATES.any? do |a|
      a & b == a
    end
  end

  def play(cell)
    @board[cell] = 1
  end

  def valid_move?(cell)
    @board[cell].zero?
  end

  def reflect_state(str, token)
    @board.each_with_index { |state, index| str[index] = token if state == 1 }
    str
  end

  def self.bin_converter(state)
    state.reduce(0) { |acc, value| acc * 2 + value }
  end

  @@WINNER_STATES = [ # rubocop:disable Style/ClassVars, Naming/VariableName

    [1, 0, 0,
     1, 0, 0,
     1, 0, 0],

    [0, 1, 0,
     0, 1, 0,
     0, 1, 0],

    [0, 0, 1,
     0, 0, 1,
     0, 0, 1],

    [1, 1, 1,
     0, 0, 0,
     0, 0, 0],

    [0, 0, 0,
     1, 1, 1,
     0, 0, 0],

    [0, 0, 0,
     0, 0, 0,
     1, 1, 1],

    [1, 0, 0,
     0, 1, 0,
     0, 0, 1],

    [0, 0, 1,
     0, 1, 0,
     1, 0, 0]

  ].map { |state| bin_converter(state) }
end
