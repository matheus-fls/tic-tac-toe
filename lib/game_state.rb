# frozen_string_literal: false

class GameState
  def initialize
    @board = [0, 0, 0,
              0, 0, 0,
              0, 0, 0]
    @save = nil
    @winner = nil
  end

  # Will determine if it's a winning state

  def winner?
    return @winner if @winner

    b = to_i
    @winner = @@WINNER_STATES.any? { |a| a & b == a }
  end

  def play(cell)
    @board[cell] = 1
    @winner = nil
  end

  def valid_move?(cell)
    @board[cell].zero?
  end

  def reflect_state(str, token)
    @board.each_with_index { |state, index| str[index] = token if state == 1 }
    str
  end

  def store_state
    @save = @board.clone
  end

  def restore_state
    @board = @save.clone
    @winner = nil
  end

  def to_i
    GameState.bin_converter(@board)
  end

  # Class methods and constants

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
